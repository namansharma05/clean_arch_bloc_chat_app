// namanks0511       - mongodb atlas username
// RSlb5FsMM9mW5wnd  - mongodb atlas password
const express = require("express");
const dummyUserModel = require("./MOCK_DATA.json");
const http = require("http");
const app = express();

const PORT = process.env.PORT || 3000;
const server = http.createServer(app);
var io = require("socket.io")(server);

app.use(express.json());
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

io.on("connection", (socket) => {
	console.log(`new user connected `, socket.id);
	socket.on("signin", (id) => {
		clients[id] = socket;
	});

	socket.on("message", (msg) => {
		let targetId = msg.targetId;
		if (clients[targetId]) clients[targetId].emit("message", msg);
	});
});

app.post("/add-item", async (req, res) => {
	try {
		const db = client.db(dbName);
		const collection = db.collection(collectionName);

		dummyUserModel.map(async (userModel) => {
			const newUserData = {
				_id: userModel["_id"],
				_first_name: userModel["_firstName"],
				_last_name: userModel["_lastName"],
				_phone: userModel["_phone"],
				_imageUrl: userModel["_imageUrl"],
				_lastOnline: userModel["_lastOnline"],
				_status: userModel["_status"],
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

app.get("/get-user", async (req, res) => {
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

async function connectToDb() {
	await client.connect();
	const res = await client.db("admin").command({ ping: 1 });
	console.log(res);
}

server.listen(PORT, () => {
	connectToDb();
	console.log(`server is running at `, PORT);
});
