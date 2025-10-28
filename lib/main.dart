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
import 'package:pantry/pages/privacy.dart';
import 'package:pantry/splash_screen.dart';
import 'package:pantry/pages/profile.dart';
import 'package:pantry/pages/scan.dart';
import 'package:pantry/theme/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Themeprovider()),
        ChangeNotifierProvider(create: (context) => Cartmanager()),
      ],
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
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
        '/privacypolicy':(context)=> PrivacyPolicyPage(),
      },
    );
  }
}
