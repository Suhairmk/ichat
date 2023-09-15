import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ichat/controller.dart';
import 'package:ichat/firebase_options.dart';
import 'package:ichat/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ichat/provider/provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(create: (context) =>AppProvider() ,
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ichat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator or splash screen if Firebase is initializing
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else if (snapshot.hasData) {
            // User is already logged in, direct to ControllerScreen
            return Controller();
          } else {
            // New user, direct to LoginPage
            return LoginPage();
          }
        },
      ),
    );
  }
}
