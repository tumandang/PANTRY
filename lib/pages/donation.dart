import 'package:flutter/material.dart';

class DonationPage extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  DonationPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Donation',
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