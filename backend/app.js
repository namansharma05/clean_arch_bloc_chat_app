// namanks0511       - mongodb atlas username
// RSlb5FsMM9mW5wnd  - mongodb atlas password
const express = require("express");
const dummyUserModel = require("./MOCK_DATA.json");
const http = require("http");
const app = express();
const cors = require("cors");

const PORT = process.env.PORT || 3000;
const server = http.createServer(app);
var io = require("socket.io")(server);

app.use(express.json());
app.use(cors());

const { MongoClient, ServerApiVersion } = require("mongodb");

const uri =
	"mongodb+srv://namanks0511:RSlb5FsMM9mW5wnd@mumbaicluster.a6kye.mongodb.net/?retryWrites=true&w=majority&appName=MumbaiCluster";

const client = new MongoClient(uri, {
	serverApi: {
		version: ServerApiVersion.v1,
		strict: true,
		deprecationErrors: true,
	},
	serverSelectionTimeoutMS: 5000,
});

var clients = {};
const dbName = "chat_app";
const collectionName = "user_data";

async function saveMessageToDB(message) {
	try {
		const db = client.db(dbName);
		const collection = db.collection("pending_messages");
		const result = await collection.insertOne(message);
		console.log(`Message inserted with ID: ${result.insertedId}`);
	} catch (error) {
		console.error("Error saving message:", error);
	}
}

// Stores message when the user is offline
async function storeMessageForLater(message) {
	const newMessage = {
		senderId: message.senderId,
		receiverId: message.receiverId,
		content: message.content,
		timestamp: message.timeStamp,
		status: "pending", // Mark the message as pending until delivered
	};
	await saveMessageToDB(newMessage); // Save to MongoDB
}

// Send pending messages when the user is back online
async function sendPendingMessages(receiverId, socket) {
	const db = client.db("chat_app");
	const collection = db.collection("messages");
	const pendingMessages = await collection
		.find({ receiverId: receiverId, status: "pending" })
		.toArray();

	for (const msg of pendingMessages) {
		socket.emit("message", msg);
		await collection.updateOne(
			{ _id: msg._id },
			{ $set: { status: "delivered" } }
		);
	}
}

io.on("connection", (socket) => {
	console.log(`new user connected `, socket.id);
	// Join the user to their individual chat room
	// socket.on("join-room", (roomId) => {
	// 	socket.join(roomId); // Each chat will have a roomId
	// });

	// Send a message to a specific room
	// socket.on("send-message", (roomId, message) => {
	// 	io.to(roomId).emit("receive-message", message);
	// });

	socket.on("signin", (userId) => {
		console.log(`current userId is`, userId);
		clients[userId] = socket;
		sendPendingMessages(userId, socket);
	});

	socket.on("message", (msg) => {
		let receiverId = msg.receiverId;
		console.log(`received message: ${msg}`);
		if (clients[receiverId]) {
			clients[receiverId].emit("message", msg);
		} else {
			storeMessageForLater(msg);
		}
	});
	socket.on("disconnect", () => {
		let userId = Object.keys(clients).find(
			(key) => clients[key].id === socket.id
		);
		if (userId) {
			console.log(`User ${userId} disconnected`);
			delete clients[userId]; // Remove user from the list
		}
	});
});

app.post("/add-users", async (req, res) => {
	try {
		const db = client.db(dbName);
		const collection = db.collection(collectionName);

		dummyUserModel.map(async (userModel) => {
			const newUserData = {
				id: userModel["id"],
				firstName: userModel["firstName"],
				lastName: userModel["lastName"],
				phone: userModel["phone"],
				imageUrl: userModel["imageUrl"],
				lastOnline: userModel["lastOnline"],
				status: userModel["status"],
				chats: userModel["chats"],
			};

			await collection.insertOne(newUserData);
		});
		res.status(200).json({
			message: "Item added successfully",
		});
	} catch (error) {
		console.error("Error inserting data:", error);
		res.status(500).json({ message: "Failed to add item" });
	}
});

app.post("/add-message", async (req, res) => {
	const { senderId, receiverId, content, timeStamp } = req.body;
	try {
		const db = client.db(dbName);
		const collection = db.collection(collectionName);
		const updatedChatData = await collection.updateOne(
			{ id: parseInt(senderId), "chats.id": parseInt(receiverId) },
			{
				$push: {
					"chats.$.messages": {
						senderId: parseInt(senderId),
						receiverId: parseInt(receiverId),
						content: content,
						timeStamp: timeStamp,
					},
				},
				$set: {
					"chats.$.lastMessage": content,
					"chats.$.lastMessageTime": timeStamp,
				},
			}
		);
		if (updatedChatData.matchedCount === 0) {
			return res.status(404).json({ error: "User or chat not found" });
		}

		if (updatedChatData.modifiedCount === 0) {
			return res
				.status(400)
				.json({ error: "Message could not be added" });
		}
		res.status(200).json({
			message: "Message added successfully",
		});
	} catch (error) {
		console.error("Error inserting data:", error);
		res.status(500).json({ message: "Failed to add item" });
	}
});

app.get("/get-users", async (req, res) => {
	try {
		const db = client.db(dbName);
		const collection = db.collection(collectionName);

		const result = await collection.find({}).toArray();
		// console.log(result);
		res.status(200).json({
			message: "Items received successfully",
			result: result,
		});
	} catch (error) {
		console.error("Error retrieving data:", error);
		res.status(500).json({ message: "Failed to retrieve data" });
	}
});

app.get("/get-user/:id", async (req, res) => {
	const userId = req.params.id;
	try {
		const db = client.db(dbName);
		const collection = db.collection(collectionName);

		const user = await collection.findOne({ id: parseInt(userId) });
		if (user) {
			res.status(200).json({ message: "user found", user: user }); // Send the user data as a JSON response
		} else {
			res.status(404).json({ message: "User not found" });
		}
	} catch (error) {
		console.error("Error retrieving data:", error);
		res.status(500).json({ message: "Failed to retrieve data" });
	}
});

async function connectToDb() {
	await client.connect();
	const res = await client.db("admin").command({ ping: 1 });
	console.log(res);
}

server.listen(PORT, "0.0.0.0", () => {
	connectToDb();
	console.log(`server is running at `, PORT);
});
