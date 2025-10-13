import 'package:flutter/material.dart';

class Squaretile extends StatelessWidget {
  final String imagepath;
  const Squaretile({super.key ,required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        
        // border: Border.all(color: Colors.blue.shade400, width: 1.5),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
            BoxShadow(
              color: Colors.black26, 
              blurRadius: 8, 
              offset: const Offset(0, 4),
            ),
          ],
      ),
      
      child: Image.asset(
        imagepath,
        height: 40,

      ),
    );
  }
}