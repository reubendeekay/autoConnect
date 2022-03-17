import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechanic/helpers/constants.dart';
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
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Text(
                  'Chat',
                  style: TextStyle(
                    fontSize: 24,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                const Icon(
                  CupertinoIcons.search,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.more_vert),
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
      shrinkWrap: true,
      children: [
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
                      color: kPrimaryColor,
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
