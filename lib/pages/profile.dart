import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  ProfilePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'CalSans'
          ),
        ),
      ),
    );
  }
}