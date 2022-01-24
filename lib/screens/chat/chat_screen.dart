import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechanic/providers/chat_provider.dart';

import 'package:provider/provider.dart';
import 'package:mechanic/screens/chat/widgets/chat_tile.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: const [
                Text(
                  'Chat',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Icon(CupertinoIcons.search, color: Colors.white),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.more_vert),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Expanded(
            child: ChatScreenWidget(),
          )
        ],
      ),
    );
  }
}

class ChatScreenWidget extends StatelessWidget {
  static const routeName = '/chat-screen-widget';
  final uid = FirebaseAuth.instance.currentUser!.uid;

  ChatScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ChatProvider>(context).getChats();

    final contacts = Provider.of<ChatProvider>(context).contactedUsers;

    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Text('Users',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 3,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.pinkAccent,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              const Text('Groups',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey)),
            ],
          ),
        ),
        ...List.generate(
            contacts.length,
            (index) => ChatTile(
                  roomId: contacts[index].chatRoomId!,
                  chatModel: contacts[index],
                )),
        if (contacts.isEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'You have no unread messages',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  'When you contact a other users or customer care, you will be able to see their messages here.',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ],
            ),
          )
      ],
    );
  }
}
