import 'package:flutter/material.dart';
import 'package:pantry/components/Mybutton.dart';
import 'package:pantry/components/squaretile.dart';
import 'package:pantry/components/textfield.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final matrictid = TextEditingController();
    final password = TextEditingController();

    Future<void> login() async {
      final role = "student";
      final url = Uri.parse(
        'https://eduhosting.top/campusfoodpantry/api_login.php',
      );

      try {
        final response = await http.post(
          url,
          headers: {"Accept": "application/json"},
          body: {
            'id': matrictid.text.trim(),
            'password': password.text.trim(),
            'role': role,
          },
        );

        final data = jsonDecode(response.body);

        if (data['success']) {
          
          
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(
          //       'Welcome ${data['data']['name']}',
          //       style: TextStyle(
          //         color: Colors.amber,
          //         fontFamily: 'CalSans',
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // );
          // await Future.delayed(const Duration(seconds: 1));
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('name', data['data']['name']);
            await prefs.setString('id', data['data']['id']);
            await prefs.setString('role', data['data']['role']);
            await prefs.setString('email', data['data']['email']);
            Navigator.pushReplacementNamed(
              context,
              '/homepage',
            );
          
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                data['message'],
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        }
      } catch (e) {
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e', style: TextStyle(color: Colors.red)),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Image.asset(
                'assets/img/unipantry_logo.png',
                height: 300,
                width: 300,
              ),

              //Welcome Back
              Text(
                "Welcome Back!!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'SpecialGhotic',
                ),
              ),
              SizedBox(height: 25),

              //username textfield
              MyTextField(
                label: 'Matric ID',
                controller: matrictid,
                hintText: "Matric ID",
                obscureText: false,
              ),
              SizedBox(height: 15),
              //Password textfield
              MyTextField(
                label: 'Password',
                controller: password,
                hintText: "Password",
                obscureText: true,
              ),

              // forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: null, child: Text("Forgot Password")),
                  ],
                ),
              ),
              SizedBox(height: 15),
              //sign in button
              Mybutton(
                onTap: () {
                  login();
                },
              ),
              SizedBox(height: 25),

              //or Continue
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey[400]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("Or Continue With"),
                    ),
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),

              //Google  + Huawei
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Squaretile(imagepath: 'assets/img/google_icon.png'),
                  SizedBox(width: 25),
                  Squaretile(imagepath: 'assets/img/Huawei-Logo-2006.png'),
                ],
              ),
              SizedBox(height: 15),

              // first time here?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('First Time Here?'),
                  SizedBox(width: 2),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/registerpage');
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.blue.shade400),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
