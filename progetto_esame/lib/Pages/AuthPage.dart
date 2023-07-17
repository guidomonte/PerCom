import 'package:flutter/material.dart';
import 'Login.dart';
import 'Registration.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) =>
      isLogin ? Login(register: toggle) : Registration(register: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
