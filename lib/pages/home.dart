import 'package:cubaantest/pages/Homepage.dart';
import 'package:cubaantest/pages/borrow.dart';
import 'package:cubaantest/pages/cart.dart';
import 'package:cubaantest/pages/donation.dart';
import 'package:cubaantest/pages/foodpage.dart';

import 'package:cubaantest/pages/profile.dart';
import 'package:cubaantest/pages/scan.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedindex = 0;
  void _navigationBottomBar(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  final List _pages = [
    HomeContentPage(),
    FoodPage(),
    ScanPage(),
    BorrowPage(),
    ProfilePage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        centerTitle: true,
        title: Text(
          'UniPantry',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'CalSans',
          ),
        ),
      ),
      body: _pages[_selectedindex],
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              child:
                  // Icon(
                  // Icons.food_bank_rounded,
                  // size: 50,
                  //   ),
                  Image.asset(
                    'assets/img/unipantry_logo.png',
                    fit: BoxFit.contain,
                    width: 350,
                    height: 350, 
                  ),
            ),

            //Profile
            ListTile(
              leading: Icon(Icons.person),
              title: Text('P R O F I L E'),
              titleTextStyle: TextStyle(
                fontFamily: 'SpecialGhotic',
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(context, '/profilepage');
              },
            ),

            //Donate
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text('D O N A T I O N'),
              titleTextStyle: TextStyle(
                fontFamily: 'SpecialGhotic',
                color: Colors.black,
              ),
            ),

            //Help AND FAQ
            ListTile(
              leading: Icon(Icons.help),
              title: Text(' H E L P'),
              titleTextStyle: TextStyle(
                fontFamily: 'SpecialGhotic',
                color: Colors.black,
              ),
            ),

            //About
            ListTile(
              leading: Icon(Icons.info_rounded),
              title: Text('A B O U T'),
              titleTextStyle: TextStyle(
                fontFamily: 'SpecialGhotic',
                color: Colors.black,
              ),
            ),

            //Logout
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('L O G O U T'),
              titleTextStyle: TextStyle(
                fontFamily: 'SpecialGhotic',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),

      

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        currentIndex: _selectedindex,
        onTap: _navigationBottomBar,
        type: BottomNavigationBarType.fixed,
        items: [
          //Home
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            label: 'HOME',
          ),

          //Food
          BottomNavigationBarItem(
            icon: Icon(
              Icons.food_bank_outlined,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            label: 'FOOD',
          ),

          //Scan
          BottomNavigationBarItem(
            icon: Icon(
            Icons.camera_alt_outlined,
            color: Theme.of(context).colorScheme.inversePrimary,
            
            ),
            
           label: 'SCAN'),
            
          //Borrow
          BottomNavigationBarItem(
            icon: Icon(
              Icons.handshake_outlined,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            label: 'Donation',
          ),

          //Profile
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
