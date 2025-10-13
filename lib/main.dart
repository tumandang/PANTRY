import 'package:pantry/Auth_Page/login.dart';
import 'package:pantry/Auth_Page/register.dart';
import 'package:pantry/models/cartmanager.dart';
import 'package:pantry/pages/borrow.dart';
import 'package:pantry/pages/cart.dart';
import 'package:pantry/pages/chatbot.dart';
import 'package:pantry/pages/donation.dart';
import 'package:pantry/pages/foodpage.dart';
import 'package:pantry/pages/home.dart';

import 'package:pantry/pages/profile.dart';
import 'package:pantry/pages/scan.dart';
import 'package:pantry/theme/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Themeprovider()),
        ChangeNotifierProvider(create: (context) => Cartmanager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: Provider.of<Themeprovider>(context).themedata,
      routes: {
        '/loginpage':(context)=> LoginPage(),
        '/registerpage':(context)=> RegisterPage(),
        '/homepage': (context) => HomePage(),
        '/foodpage': (context) => FoodPage(),
        '/profilepage': (context) => ProfilePage(),
        '/scanpage' : (context) => ScanPage(),
        '/donationpage' : (context) => DonationPage(),
        '/borrowpage' : (context) => BorrowPage(),
         '/cartpage': (context) => CartPage(),
         '/chatbotpage' : (context) => ChatbotPage()
      },
    );
  }
}
