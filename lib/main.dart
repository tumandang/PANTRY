import 'package:pantry/Auth_Page/login.dart';
import 'package:pantry/Auth_Page/register.dart';
import 'package:pantry/models/cartmanager.dart';
import 'package:pantry/pages/borrow.dart';
import 'package:pantry/pages/cart.dart';
import 'package:pantry/pages/chatbot.dart';
import 'package:pantry/pages/donation.dart';
import 'package:pantry/pages/foodpage.dart';
import 'package:pantry/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pantry/pages/profile.dart';
import 'package:pantry/pages/scan.dart';
import 'package:pantry/theme/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: islog ? HomePage() : LoginPage(),
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
