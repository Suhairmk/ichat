import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Calls',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 15, // Number of calls
        itemBuilder: (BuildContext context, int index) {
          // You can customize the call details here
          String callerName = 'John Doe';
          String callType = 'Missed'; // Add the call type (Missed, Incoming, Outgoing)
          String callDuration = '5:30'; // Add the call duration (hh:mm)
          String callTime = '2 minutes ago';

          return ListTile(
            leading: CircleAvatar(
              // You can set a profile image for the caller here
              backgroundColor: Colors.grey, // Replace with the actual image
              radius: 30,
            ),
            title: Text(callerName),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$callType Call',
                  style: TextStyle(
                    color: callType == 'Missed'
                        ? Colors.red // Customize color for missed calls
                        : Colors.black,
                  ),
                ),
                Text(callTime),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(callDuration),
                Icon(
                  Icons.call, // You can customize the call icon
                  color: callType == 'Missed'
                      ? Colors.red // Customize color for missed calls
                      : Colors.green, // Customize color for other calls
                ),
              ],
            ),
            onTap: () {
              // Handle tap on a call item
            },
          );
        },
      ),
    );
  }
}
