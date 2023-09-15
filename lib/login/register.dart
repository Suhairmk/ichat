import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ichat/actions/imagepicker.dart';
import 'package:ichat/login/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23, // Set the title font size
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Imagepicker(
              onPickImage: ((pickedImage) {
                _selectedImage = pickedImage;
              }),
            ),
            // Name TextField with curved border
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Add curved border
                ),
              ),
            ),
            SizedBox(height: 20),
            // Email TextField with curved border
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Add curved border
                ),
              ),
            ),
            SizedBox(height: 20),
            // Username TextField with curved border
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Add curved border
                ),
              ),
            ),
            SizedBox(height: 20),
            // Password TextField with curved border
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Add curved border
                ),
              ),
            ),
            SizedBox(height: 20),
            // Register Button with modified width
            SizedBox(
              width: MediaQuery.of(context).size.width -
                  20, // Set the button width
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    if (userCredential.user != null) {
                      // Successfully registered
                           final storageRef = FirebaseStorage.instance
                          .ref()
                          .child('user_images')
                          .child('${userCredential.user!.uid}.jpg');

                      await storageRef.putFile(_selectedImage!);
                      final imageaurl = await storageRef.getDownloadURL();
           
                      // Store user data in Firestore
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userCredential.user!.uid)
                          .set({
                        'username': usernameController.text,
                        'email': emailController.text,
                        'name': nameController.text,
                        'image_url':imageaurl, // Add the user's name
                      });

                               
                      // Successfully registered and logged in, you can now navigate to the login screen or perform any other action.
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  } catch (e) {
                    print(
                        'Error during registration: $e'); // Print the error message to the console
                    String errorMessage = 'Registration failed';
                    if (e is FirebaseAuthException) {
                      switch (e.code) {
                        case 'weak-password':
                          errorMessage = 'The password is too weak.';
                          break;
                        case 'email-already-in-use':
                          errorMessage =
                              'The account already exists for that email.';
                          break;
                        case 'invalid-email':
                          errorMessage = 'The email address is not valid.';
                          break;
                        // Add more cases for other possible errors
                        default:
                          errorMessage = 'An error occurred while registering.';
                          break;
                      }
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                      ),
                    );
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 18, // Adjust the button text size
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
