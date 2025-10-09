import 'package:flutter/material.dart';
import 'package:pantry/models/MessageAI.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Messageai> mymessage = [
    Messageai(message: "HAI APA KHABAR", IsUser: true),
    Messageai(message: "SAYA ROBOT", IsUser: false),
    Messageai(message: "Okay", IsUser: true),
    Messageai(message: "Saya Robot", IsUser: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        leading: IconButton(
          icon : Icon(Icons.arrow_back_ios_rounded),
          color: Colors.amber,
          onPressed:()=> Navigator.of(context).pop()
        ),
        title: Text.rich(
          TextSpan(
            text: "Bread",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: "Bot",
                style: TextStyle(color: Colors.amberAccent),
              ),
            ],
          ),
        ),

        actions: [
          Padding(padding: EdgeInsets.all(12)),
          Container(
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              icon: Icon(Icons.info_outline, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: mymessage.length,
                itemBuilder: (context, index) {
                  final message = mymessage[index];
                  return ListTile(
                    title: Align(
                      alignment: message.IsUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: message.IsUser
                              ? Colors.amber
                              : Colors.grey.shade300,
                          borderRadius: message.IsUser
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )
                              : BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                        ),
                        child: Text(
                          message.message,
                          style: TextStyle(
                            color: message.IsUser ? Colors.white : Colors.black, fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // user input
            Padding(
              padding: const EdgeInsets.only(
                bottom: 32,
                top: 16,
                right: 16,
                left: 16,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 7),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Write Your Message",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                    ),
        
                    IconButton(onPressed: () {}, icon: Icon(Icons.send)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
