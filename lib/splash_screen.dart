import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pantry/pages/home.dart';
import 'package:pantry/Auth_Page/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
   
    await Future.delayed(Duration(seconds:8));


    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getString('id') != null;


    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => isLoggedIn ? HomePage() : const LoginPage(),
        ),
      );
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white, 
    body: SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover, 
        child: Lottie.asset(
          'assets/lottie/splash_intro.json',
        ),
      ),
    ),
  );
}
}
