import 'package:flutter/material.dart';

class DonationType extends StatelessWidget {
  final String title;
  final IconData icon;
  const DonationType({
    super.key,
    required this.title,
    required this.icon,
    });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Text(
            title,
          ),
        ],
      ),
    );
  }
   
  
}
List <DonationType> mydonationtype = [
  DonationType(title: 'Food', icon: Icons.food_bank_rounded),
  DonationType(title: 'Money', icon: Icons.attach_money_rounded),
];