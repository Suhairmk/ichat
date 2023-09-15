import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ichat/controller.dart';
import 'package:ichat/login/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Email TextField
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Add curved border
                ),
              ),
              keyboardType: TextInputType.emailAddress, // Set keyboard type
            ),
            SizedBox(height: 20),
            // Password TextField
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
              keyboardType: TextInputType.text, // Set keyboard type
            ),
            SizedBox(height: 20),
            // Login Button with modified width
            SizedBox(
              width: screenWidth - 20, // Set the button width
              child: ElevatedButton(
                onPressed: () async {
                  // Check if the input is an email or a username
                  final input = emailController.text;
                  final isEmail = input.contains("@");
                  try {
                    if (isEmail) {
                      // Email login
                      final UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                        email: input,
                        password: passwordController.text,
                      );
                      // Successful login, navigate to the home screen
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Controller()));
                    } else {
                      // Username login
                      final QuerySnapshot result = await FirebaseFirestore
                          .instance
                          .collection('users')
                          .where('username', isEqualTo: input)
                          .get();

                      if (result.docs.isNotEmpty) {
                        print('username done');
                        final email = result.docs[0].get('email');
                        final UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: email,
                          password: passwordController.text,
                        );
                        // Successful login, navigate to the home screen
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Controller()));
                        
                      } else {
                        // Username not found, show an error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Username not found.'),
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    // Handle login error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Login failed. Please check your email/username and password.'),
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
            ),
            // Sign-up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account? '),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
