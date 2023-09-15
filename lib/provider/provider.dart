import 'package:flutter/material.dart';
import 'package:ichat/model/chatroom.dart';

class AppProvider extends ChangeNotifier {
  List<ChatRoomInfo> knowChats = []; // Store ChatRoomInfo objects here

  // Add a method to populate the chat rooms with data
  // void populateChatRooms() {
  //   // Clear existing data (if needed)
  //   knowChats.clear();

  //   // Add chat room data
  //   knowChats.add(ChatRoomInfo(
  //     chatRoomId: "chat_room_id_1",
  //     usernames: ["User1", "User2"],
  //     lastMessage: "Hello, how are you?",
  //   ));

  //   knowChats.add(ChatRoomInfo(
  //     chatRoomId: "chat_room_id_2",
  //     usernames: ["User3", "User4"],
  //     lastMessage: "I'm good, thanks!",
  //   ));

    // Notify listeners after updating the list
   // notifyListeners();
 // }
   void addToKnowChats(ChatRoomInfo chatRoomInfo) {
    knowChats.add(chatRoomInfo);
    notifyListeners(); // Notify listeners of the change
  }
}
