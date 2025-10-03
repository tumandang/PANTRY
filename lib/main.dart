import 'package:cubaantest/models/cartmanager.dart';
import 'package:cubaantest/pages/borrow.dart';
import 'package:cubaantest/pages/cart.dart';
import 'package:cubaantest/pages/donation.dart';
import 'package:cubaantest/pages/home.dart';

import 'package:cubaantest/pages/profile.dart';
import 'package:cubaantest/pages/scan.dart';
import 'package:cubaantest/theme/themeprovider.dart';
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
        '/profilepage': (context) => ProfilePage(),
        '/scanpage' : (context) => ScanPage(),
        '/donationpage' : (context) => DonationPage(),
        '/borrowpage' : (context) => BorrowPage(),
         '/cartpage': (context) => CartPage()
      },
    );
  }
}
