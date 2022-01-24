import 'package:flutter/material.dart';
import 'package:mechanic/providers/chat_provider.dart';
import 'package:mechanic/screens/chat/widgets/chat_tile.dart';
import 'package:provider/provider.dart';

class ChatScreenSearch extends StatefulWidget {
  static const routeName = '/chat-screen-search';

  const ChatScreenSearch({Key? key}) : super(key: key);

  @override
  _ChatScreenSearchState createState() => _ChatScreenSearchState();
}

class _ChatScreenSearchState extends State<ChatScreenSearch> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final contacts = Provider.of<ChatProvider>(context)
        .contactedUsers
        .where((element) =>
            element.user!.fullName!.contains(searchController.text))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          autofocus: true,
          onChanged: (value) {
            setState(() {});
          },
          decoration: const InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView(
        children: [
          if (searchController.text.isNotEmpty)
            ...List.generate(
                contacts.length,
                (index) => ChatTile(
                      roomId: contacts[index].chatRoomId!,
                      chatModel: contacts[index],
                    ))
        ],
      ),
    );
  }
}
