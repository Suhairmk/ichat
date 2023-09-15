import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ichat/provider/provider.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  final int index;
  final String chatRoomId;
  final List<String> usernames;
  const MessageScreen(
      {Key? key,
      required this.index,
      required this.chatRoomId,
      required this.usernames})
      : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController inputMessage = TextEditingController();
  Color sentIconColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    String userName = provider.knowChats[widget.index].usernames[0];
    String userStatus = 'Online';
    CollectionReference messages =
        FirebaseFirestore.instance.collection('messages');

    return Scaffold(
      backgroundColor: Color.fromARGB(187, 119, 196, 121),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black, // Set the icon color to black
          ),
          onPressed: () {
            Navigator.pop(
                context); // Navigate back when the back button is pressed
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              // Replace with the user's profile image
              // backgroundImage: NetworkImage('https://example.com/your-profile-image.jpg'),
              radius: 20,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  userStatus,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle the call icon tap
            },
            icon: Icon(
              Icons.call,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle the video call icon tap
            },
            icon: Icon(
              Icons.videocam,
              color: Colors.black,
            ),
          ),
        ],
      ),

      //starting the body
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messages
                  .where('chatId', isEqualTo: widget.chatRoomId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return Text('Error: ${snapshot.error}');
                }

                List<DocumentSnapshot> messageDocs = snapshot.data!.docs;

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  reverse: true,
                  itemCount: messageDocs.length,
                  itemBuilder: (context, index) {
                    var messageData =
                        messageDocs[index].data() as Map<String, dynamic>;
                    String messageContent = messageData['content'];
                    String senderId = messageData['sender'];
                    Timestamp timestamp = messageData['timestamp'];
                    bool isCurrentUser =
                        FirebaseAuth.instance.currentUser?.uid == senderId;

                    return MessageBubble(
                      key: UniqueKey(),
                      messageContent: messageContent,
                      isCurrentUser: isCurrentUser,
                      timestamp: timestamp,
                      onDeletePressed: () {
                        // Handle message deletion
                        if (isCurrentUser) {
                          // You can delete the message here
                          FirebaseFirestore.instance
                              .collection('messages')
                              .doc(messageDocs[index].id)
                              .delete();
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          MessageInputBar(
            inputMessage: inputMessage,
            sentIconColor: sentIconColor,
            onSendPressed: () async {
              String messageContent = inputMessage.text.trim();
              final user = FirebaseAuth.instance.currentUser!;
              final userdata = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get();
              if (messageContent.trim().isNotEmpty) {
                messages.add({
                  'chatId': widget.chatRoomId,
                  'content': messageContent,
                  'sender': user.uid,
                  'timestamp': FieldValue.serverTimestamp(),
                });

                inputMessage.clear();

                setState(() {
                  sentIconColor = Colors.black;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String messageContent;
  final bool isCurrentUser;
  final Timestamp timestamp;
  final Function()? onDeletePressed;

  const MessageBubble({
    required Key key,
    required this.messageContent,
    required this.isCurrentUser,
    required this.timestamp,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(), // Provide a unique key for each message
      onDismissed: (direction) {
        // Handle message deletion when swiped away
        if (direction == DismissDirection.endToStart) {
          onDeletePressed?.call();
        }
      },
      background: Container(
        color: Colors.red,
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Align(
        alignment: isCurrentUser ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomRight:
                  isCurrentUser ? Radius.circular(0) : Radius.circular(20),
              bottomLeft:
                  isCurrentUser ? Radius.circular(20) : Radius.circular(0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                messageContent, // Display the message content here
                style: TextStyle(
                  fontSize: 16,
                  color: isCurrentUser ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '${timestamp.toDate().hour}:${timestamp.toDate().minute}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageInputBar extends StatelessWidget {
  final TextEditingController inputMessage;
  Color sentIconColor;
  final Function() onSendPressed;

  MessageInputBar({
    Key? key,
    required this.inputMessage,
    required this.sentIconColor,
    required this.onSendPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
                // Handle the image icon tap
              },
              child: Icon(
                Icons.image,
                color: Colors.black,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // Handle the camera icon tap
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              // Handle the link icon tap
            },
            child: Icon(
              Icons.link,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 3,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    enableSuggestions: true,
                    autocorrect: true,
                    textCapitalization: TextCapitalization.sentences,
                    controller: inputMessage,
                    onChanged: (text) {
                      sentIconColor = text.isEmpty ? Colors.black : Colors.blue;
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                InkWell(
                  onTap: onSendPressed,
                  child: Icon(
                    Icons.send,
                    color: sentIconColor,
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
