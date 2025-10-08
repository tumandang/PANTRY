import 'package:PANTRY/models/cartmanager.dart';
import 'package:PANTRY/pages/borrow.dart';
import 'package:PANTRY/pages/cart.dart';
import 'package:PANTRY/pages/donation.dart';
import 'package:PANTRY/pages/foodpage.dart';
import 'package:PANTRY/pages/home.dart';

import 'package:PANTRY/pages/profile.dart';
import 'package:PANTRY/pages/scan.dart';
import 'package:PANTRY/theme/themeprovider.dart';
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
      home: HomePage(),
      theme: Provider.of<Themeprovider>(context).themedata,
      routes: {
        '/homepage': (context) => HomePage(),
        '/foodpage': (context) => FoodPage(),
        '/profilepage': (context) => ProfilePage(),
        '/scanpage' : (context) => ScanPage(),
        '/donationpage' : (context) => DonationPage(),
        '/borrowpage' : (context) => BorrowPage(),
         '/cartpage': (context) => CartPage()
      },
    );
  }
}
