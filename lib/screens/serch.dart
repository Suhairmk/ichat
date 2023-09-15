import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ichat/model/chatroom.dart';
import 'package:ichat/provider/provider.dart';
import 'package:ichat/screens/messagescreen.dart';
import 'package:provider/provider.dart';

class UserSearchScreen extends StatefulWidget {
  
  const UserSearchScreen({super.key});

  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final TextEditingController searchController = TextEditingController();
List<Map<String, Object>?> searchResults = [];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Search People',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: CupertinoSearchTextField(
              controller: searchController,
              onChanged: performSearch,
              placeholder: 'Search by username',
            ),
          ),
          Expanded(
            child: ListView.builder(
  itemCount: searchResults.length,
  itemBuilder: (context, index) {
    final userData = searchResults[index];
    final chatRoomInfo = userData!['chatRoomInfo'] as ChatRoomInfo;

    // Customize the display of user profiles here
    return InkWell(
      onTap: () {
        // Adding tapped chats to the main chat screen (knowing chats)
        provider.addToKnowChats(chatRoomInfo);

       // Navigate to the message screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageScreen(
              index: index,
              chatRoomId: chatRoomInfo.chatRoomId,
              usernames: chatRoomInfo.usernames,
            ),
          ),
        );
      },
      child: Container(
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, top: 4, bottom: 4),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black12,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(chatRoomInfo.usernames.join(', ')),
          ],
        ),
      ),
    );
  },
)

          ),
        ],
      ),
    );
  }

   void performSearch(String query) async {
  if (query.isNotEmpty) {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query)
        .where('username', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    print('Search results: ${result.docs}');

    final searchResultsWithChatInfo = await Future.wait(
      result.docs.map((userDoc) async {
        final userData = userDoc.data() as Map<String, dynamic>;
        final username = userData['username'] as String;

        final chatRoomQuery = await FirebaseFirestore.instance
            .collection('chat_rooms')
            .where('usernames', arrayContains: username)
            .get();

        if (chatRoomQuery.docs.isNotEmpty) {
          final chatRoomData = chatRoomQuery.docs[0].data() as Map<String, dynamic>;
          final chatRoomId = chatRoomQuery.docs[0].id;
          final lastMessage = chatRoomData['lastMessage'] as String;
          final imageUrl=chatRoomData['imageUrl'] as String;

          final chatRoomInfo = ChatRoomInfo(
            chatRoomId: chatRoomId,
            usernames: chatRoomData['usernames'].cast<String>(),
            lastMessage: lastMessage,
            imageUrl: imageUrl,
          );

          return {
            'userDoc': userDoc,
            'chatRoomInfo': chatRoomInfo,
          };
        } else {
          // Return a placeholder chat room info for users without chat rooms
          final chatRoomInfo = ChatRoomInfo(
            chatRoomId: 'no_chat_room_id',
            usernames: [username],
            lastMessage: 'No chat room created yet.',
            imageUrl: 'https://w7.pngwing.com/pngs/527/663/png-transparent-logo-person-user-person-icon-rectangle-photography-computer-wallpaper-thumbnail.png',
          );

          return {
            'userDoc': userDoc,
            'chatRoomInfo': chatRoomInfo,
          };
        }
      }),
    );

    print('Search results with chat info: $searchResultsWithChatInfo');

    setState(() {
      searchResults = searchResultsWithChatInfo
          .where((result) => result != null)
          .toList();
    });

    print('Filtered search results: $searchResults');
  } else {
    setState(() {
      searchResults.clear();
    });
  }
}



}
