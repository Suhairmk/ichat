import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ichat/provider/provider.dart';
import 'package:ichat/screens/messagescreen.dart';
import 'package:ichat/screens/serch.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'ichat',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 40,
                  width: width - 70,
                  child: CupertinoSearchTextField(),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserSearchScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 40,
                    child: Image(
                      image: AssetImage(
                        'assets/images/serchperson.png',
                      ),
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Broadcast List'), Text('New Group')],
            ),
          ),
          Container(
            height: 92,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color.fromARGB(255, 243, 205, 33),
                        // Here, you can use an image URL for the profile image
                        // Replace 'imageUrl' with the actual URL from Firebase
                        backgroundImage: NetworkImage('imageUrl'), 
                      ),
                      Text('name')
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: height - 300,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.black12,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width - 390,
                      ),
                      Text('Chats'),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.knowChats.length,
                    itemBuilder: (BuildContext context, int index) {
                      final chatRoomInfo = provider.knowChats[index];
                      return InkWell(
                        onTap: () {
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
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 4,
                                left: 8,
                                right: 8,
                                top: 4,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        // Here, you can use an image URL for the profile image
                                        // Replace 'imageUrl' with the actual URL from Firebase
                                        backgroundImage: NetworkImage('imageUrl'), 
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            chatRoomInfo.usernames.join(', '),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(chatRoomInfo.lastMessage),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '12:34 PM',
                                    style: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
