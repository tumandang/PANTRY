import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pantry/models/MessageAI.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Messageai> mymessage = [];
  bool _isLoading = false;

  Future<void> sendMessage() async {
    final userText = _controller.text.trim();
    if (userText.isEmpty) return;

    setState(() {
      mymessage.add(Messageai(message: userText, IsUser: true));
      _controller.clear();
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse("https://eduhosting.top/campusfoodpantry/chatbot.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": userText}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data["reply"] ?? "Sorry, I didn’t get that.";

        setState(() {
          mymessage.add(Messageai(message: reply, IsUser: false));
        });
        print(
          "Metadata: ${{'generated_by': 'AI', 'type': 'text', 'timestamp': DateTime.now().toString()}}",
        );
      } else {
        setState(() {
          mymessage.add(
            Messageai(
              message: "Server error: ${response.statusCode}",
              IsUser: false,
            ),
          );
        });
      }
    } catch (e) {
      setState(() {
        mymessage.add(Messageai(message: "Error: $e", IsUser: false));
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.blue,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text.rich(
          TextSpan(
            text: "AI-",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: "DEAL",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
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
                              ? Colors.blue
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
                        child: Column(
                          crossAxisAlignment: message.IsUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            if (!message.IsUser) 
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  "AI-generated",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            Text(
                              message.message,
                              style: TextStyle(
                                color: message.IsUser
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ),
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
                          hintText: "Write your message...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: sendMessage,
                      icon: Icon(Icons.send, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
