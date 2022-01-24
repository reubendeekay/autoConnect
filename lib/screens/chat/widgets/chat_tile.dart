import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/providers/chat_provider.dart';
import 'package:mechanic/screens/chat/chat_room.dart';
import 'package:intl/intl.dart';

class ChatTile extends StatelessWidget {
  final String roomId;
  final ChatTileModel? chatModel;
  ChatTile({Key? key, required this.roomId, this.chatModel}) : super(key: key);
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(ChatRoom.routeName, arguments: {
        'chatRoomId': roomId,
        'user': chatModel!.user,
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            Row(children: [
              CircleAvatar(
                radius: 26,
                backgroundImage:
                    CachedNetworkImageProvider(chatModel!.user!.imageUrl!),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          chatModel!.user!.fullName!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (chatModel!.user!.isMechanic!)
                          const Icon(
                            Icons.verified,
                            color: kPrimaryColor,
                            size: 16,
                          ),
                        const Spacer(),
                        Text(
                          DateFormat('HH:mm').format(chatModel!.time!.toDate()),
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                        )
                      ],
                    ),
                    Text(
                      '${chatModel!.latestMessageSenderId == uid ? 'You: ' : ''}${chatModel!.latestMessage}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ]),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
