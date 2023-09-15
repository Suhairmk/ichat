import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ichat/actions/imagepicker.dart';
import 'package:ichat/login/login.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Log out the current user
    void logOutUser() async {
      try {
        await FirebaseAuth.instance.signOut();
        // User is now logged out
      } catch (e) {
        // Handle log out error here
        print('Error logging out: $e');
      }
    }

    File? _selectedImage;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the background color to white
        elevation: 0, // Set elevation to 0
        title: Text(
          'Settings',
          style:
              TextStyle(color: Colors.black), // Set title text color to black
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                CupertinoSearchTextField(), // Add the search field at the top
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Imagepicker(
                  onPickImage: ((pickedImage) {
                    _selectedImage = pickedImage;
                  }),
                ),
                SizedBox(
                  width: 4,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Name',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight:
                                FontWeight.bold), // Set text color to black
                      ),
                      Text(
                        'View and edit profile',
                        style: TextStyle(
                            color: Colors.black), // Set text color to black
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ListTile(
          //   dense: true,
          //   leading: Expanded(child: Imagepicker()),

          //   // CircleAvatar(
          //   //   backgroundColor: Colors.grey,
          //   //   radius: 30,
          //   // ),
          //   title: Text(
          //     'Your Name',
          //     style: TextStyle(color: Colors.black), // Set text color to black
          //   ),
          //   subtitle: Text(
          //     'View and edit profile',
          //     style: TextStyle(color: Colors.black), // Set text color to black
          //   ),
          //   trailing: Icon(
          //     Icons.arrow_forward_ios,
          //     color: Colors.black, // Set icon color to black
          //   ),
          //   onTap: () {
          //     // Handle tap on profile section
          //     // Navigator.push(context,
          //     //     MaterialPageRoute(builder: (context) => Imagepicker()));
          //   },
          // ),

          Divider(),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.black, // Set icon color to black
            ),
            title: Text(
              'Avatar',
              style: TextStyle(color: Colors.black), // Set text color to black
            ),
            onTap: () {
              // Handle tap on Avatar option
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Starred Messages'),
            onTap: () {
              // Handle tap on Starred Messages option
            },
          ),
          ListTile(
            leading: Icon(Icons.devices),
            title: Text('Linked Devices'),
            onTap: () {
              // Handle tap on Linked Devices option
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Account'),
            onTap: () {
              // Handle tap on Account option
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy'),
            onTap: () {
              // Handle tap on Privacy option
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chats'),
            onTap: () {
              // Handle tap on Chats option
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Handle tap on Notifications option
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Payments'),
            onTap: () {
              // Handle tap on Payments option
            },
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('Storage and Data'),
            onTap: () {
              // Handle tap on Storage and Data option
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help and Suggestions'),
            onTap: () {
              // Handle tap on Help and Suggestions option
            },
          ),

          //make a widget here to log out and perform log out when it press
          // Log Out button
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              // When Log Out is pressed, call the _logOut method
              logOutUser();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
