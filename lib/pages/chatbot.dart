import 'package:flutter/material.dart';
class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        
        title: Text.rich(
          TextSpan(
            text: "Bread",
            style: TextStyle(color: Colors.white),
            children: [
              TextSpan(
                text:"Bot",
                style: TextStyle(color: Colors.amberAccent) 
              )
          ])
        ),
        
        actions: [
          Padding(padding: EdgeInsets.all(12)),
          Container(
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              icon: Icon(Icons.info_outline, color: Colors.white,),
              onPressed: () {
               
              },
            ),
          ),
        ],
      ),
    );
  }
}