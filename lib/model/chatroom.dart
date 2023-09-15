// class ChatRoom {
//   final String chatId;
//   final String name;
//   final List<String> participants;
//   final List<Map<String, dynamic>> messages;

//   ChatRoom({
//     required this.chatId, // Add chatId property
//     required this.name,
//     required this.participants,
//     required this.messages,
//   });
// }
class ChatRoomInfo {
  final String chatRoomId;
  final List<String> usernames;
  final String lastMessage;
  final String imageUrl;

  ChatRoomInfo({
    required this.chatRoomId,
    required this.usernames,
    required this.lastMessage,
    required this.imageUrl,
  });
}
