import 'package:clean_arch_bloc_chat_app/utils/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndividualChatBottomBarWidget extends StatelessWidget {
  const IndividualChatBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          // chatting area
          Expanded(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: theme().secondaryHeaderColor,
                borderRadius: BorderRadius.circular(27),
              ),
              child: Row(
                children: [
                  // icon pallet
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.emoji_emotions_outlined,
                        size: 30,
                      )),
                  // textfield
                  Expanded(
                    child: TextField(
                      // autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // attachment, money transfer, camera
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.attach_file,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.money_dollar_circle_fill,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            size: 30,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            width: 5,
          ),
          // record audio
          Container(
            height: 60,
            width: 60,
            child: Icon(
              Icons.mic,
              color: Colors.black,
              size: 30,
            ),
            decoration: BoxDecoration(
              color: theme().primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
          )
        ],
      ),
    );
  }
}
