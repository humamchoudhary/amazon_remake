import 'package:flutter/material.dart';
import 'package:notamazon/Screens/Login.dart';

import '../Screens/Home.dart';

bool AUTH = false;
class Auth extends StatefulWidget {
  Auth({super.key});
  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return AUTH? Home():Login();
  }
}