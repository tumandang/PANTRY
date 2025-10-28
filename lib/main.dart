import 'package:pantry/Auth_Page/login.dart';
import 'package:pantry/Auth_Page/register.dart';
import 'package:pantry/QR-way/QRProduct.dart';
import 'package:pantry/QR-way/cartQr.dart';
import 'package:pantry/models/cartmanager.dart';
import 'package:pantry/pages/borrow.dart';
import 'package:pantry/pages/cart.dart';
import 'package:pantry/pages/chatbot.dart';
import 'package:pantry/pages/donation.dart';
import 'package:pantry/pages/foodpage.dart';
import 'package:pantry/pages/helppage.dart';
import 'package:pantry/pages/home.dart';
import 'package:pantry/pages/order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pantry/pages/profile.dart';
import 'package:pantry/pages/scan.dart';
import 'package:pantry/theme/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getString('id') != null;
  runApp(
    

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Themeprovider()),
        ChangeNotifierProvider(create: (context) => Cartmanager()),
      ],
      child:  MyApp(islog: isLoggedIn,),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool islog;
  const MyApp({super.key,required this.islog});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(isLoggedIn: islog),
      theme: Provider.of<Themeprovider>(context).themedata,
      routes: {
        '/loginpage':(context)=> LoginPage(),
        '/registerpage':(context)=> RegisterPage(),
        '/homepage': (context) => HomePage(),
        '/foodpage': (context) => FoodPage(),
        '/profilepage': (context) => ProfilePage(),
        '/scanpage' : (context) => QRScanPage(),
        '/donationpage' : (context) => DonationPage(),
        '/borrowpage' : (context) => BorrowPage(),
        '/cartpage': (context) => CartPage(),
        '/chatbotpage' : (context) => ChatbotPage(),
        '/helppage' : (context) => HelpPage(),
        '/OrderHistory':(context)=> OrderHistoryPage(),
        '/ProductQr':(context) => Qrproduct(),
        '/CartQR':(context)=>CartQRPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;
  
  const SplashScreen({super.key, required this.isLoggedIn});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _animationCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    // tunggu animation main sampai habis
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_animationCompleted) {
        _animationCompleted = true;
        _navigateToNextScreen();
      }
    });
    
    // Tayangan bermula
    _controller.forward();
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget.isLoggedIn ? HomePage() : LoginPage(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Lottie.asset(
          'assets/animations/splash_intro.json',
          controller: _controller,
          fit: BoxFit.cover, // Display full tapi x 4k
        ),
      ),
    );
  }
}