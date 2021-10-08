import 'package:flutter/material.dart';

class UpdatePasswordPage extends StatefulWidget {
  static String id = 'update_password_page';
  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}
