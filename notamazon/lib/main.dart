import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:notamazon/Screens/Login.dart';
import 'package:notamazon/Screens/SignUp.dart';
import 'package:notamazon/Screens/item_details.dart';
import 'package:notamazon/Services/Auth.dart';
import 'Screens/Home.dart';

import 'Screens/Home.dart';
// import 'package:flutter/material.dart';
String URL = 'http://192.168.8.128:5000';

const apiKey = "AIzaSyBkpgbuujpZaYSWvqR898rpa9REEZzl3UU";
const projectId = "not-7834b";
Brightness mode = Brightness.light;
void main()async {
  FirebaseAuth.initialize(apiKey, VolatileStore());
  await Firestore.initialize(projectId);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      
      home:Auth(),
      routes: {
        // "/login":(context) =>Login(),
        "/auth":(context) =>Auth(),
        "/signup":(context) =>SignUp(),

      },
    );
  }
}
