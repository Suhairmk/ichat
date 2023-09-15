import 'package:flutter/material.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Status',style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.pop(context); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: Column(
        children: [
          // Status Upload Section
          ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/your_profile_image.jpg'), // Change to your profile image
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            title: Text('My Status'),
            subtitle: Text('Tap to add status update'),
            trailing: Icon(Icons.more_vert), // Three dots icon
            onTap: () {
              // Handle tap on the status upload section
            },
          ),

          // Divider
          Divider(height: 1),

          // Contacts Text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Contacts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),

          // Status List
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                // You can customize the status names and images here
                String statusName = 'Statusname';
                String imageUrl = 'assets/status_$index.jpg';

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(imageUrl),
                    radius: 30,
                  ),
                  title: Text(statusName),
                  subtitle: Text('2 minutes ago'), // You can customize this as needed
                  trailing: Icon(Icons.more_horiz),
                  onTap: () {
                    // Handle tap on a status item
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
