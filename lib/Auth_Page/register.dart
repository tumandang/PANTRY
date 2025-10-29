import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pantry/components/Mybutton.dart';

import 'package:pantry/components/textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final matrictid = TextEditingController();
  final email = TextEditingController();
  final name = TextEditingController();
  final confirmPassword = TextEditingController();
  final password = TextEditingController();
  bool _agreeToPrivacy = false;

  Future<void> _register() async {
    final role = "Student";
    final url = Uri.parse(
      'https://eduhosting.top/campusfoodpantry/api_register.php',
    );
    if (!_agreeToPrivacy) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You must agree to the Privacy Policy to continue",
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
      return;
    }
    if (password.text != confirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Password Does not match",
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          'name': name.text,
          'id': matrictid.text,
          'email': email.text,
          'password': password.text.trim(),
          'confirmPassword': confirmPassword.text.trim(),
          'role': role,
        }),
      );

      final data = jsonDecode(response.body);

      if (data['success']) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', name.text);
        await prefs.setString('id', matrictid.text);
        await prefs.setString('role', 'Student');
        await prefs.setString('email', email.text);
        Navigator.pushReplacementNamed(context, '/homepage');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'], style: TextStyle(color: Colors.red)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Welcome Back
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    // logo
                    children: [
                      Image.asset(
                        'assets/img/unipantry_logo.png',
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create Account",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'SpecialGhotic',
                            ),
                          ),

                          Text(
                            "Every Student Deserves a Meal",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontFamily: 'CalSans',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),

                //username textfield
                MyTextField(
                  label: 'Name',
                  controller: name,
                  hintText: "Name",
                  obscureText: false,
                ),
                SizedBox(height: 15),
                //username textfield
                MyTextField(
                  label: 'Email',
                  controller: email,
                  hintText: "Your Email",
                  obscureText: false,
                ),
                SizedBox(height: 15),
                //username textfield
                MyTextField(
                  label: 'Matric ID',
                  controller: matrictid,
                  hintText: "Your Matric ID",
                  obscureText: false,
                ),
                SizedBox(height: 15),
                //Password textfield
                MyTextField(
                  label: 'Password',
                  controller: password,
                  hintText: "Your Password",
                  obscureText: true,
                ),
                SizedBox(height: 15),

                //confirm Password textfield
                MyTextField(
                  label: 'Confirm Password',
                  controller: confirmPassword,
                  hintText: "Re-Type Your Password",
                  obscureText: true,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _agreeToPrivacy,
                        onChanged: (value) {
                          setState(() {
                            _agreeToPrivacy = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Optionally open Privacy Policy page
                            Navigator.pushNamed(context, '/privacypolicy');
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "I agree to the ",
                              children: [
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                //sign in button
                Mybutton(
                  onTap: () {
                    _register();
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
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      //   child: Text("Or Continue With"),
                      // ),
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),

                // //Google  + Huawei
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Squaretile(imagepath: 'assets/img/google_icon.png'),
                //     SizedBox(width: 25),
                //     Squaretile(imagepath: 'assets/img/Huawei-Logo-2006.png'),
                //   ],
                // ),
                // SizedBox(height: 15),

                // first time here?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have An Account?'),
                    SizedBox(width: 2),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/loginpage');
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.blue.shade400),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}