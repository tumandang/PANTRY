import 'package:pantry/pages/Homepage.dart';
// import 'package:pantry/pages/borrow.dart';
// import 'package:pantry/pages/cart.dart';
import 'package:pantry/pages/donation.dart';
import 'package:pantry/pages/foodpage.dart';
import 'package:pantry/pages/profile.dart';
import 'package:pantry/pages/scan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
Future<void>logout(BuildContext context) async{
  final prefs = await SharedPreferences.getInstance();

  await prefs.clear();

  Navigator.pushNamedAndRemoveUntil(context, '/loginpage', (route)=>false,);
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
    QRScanPage(),
    DonationPage(),
    ProfilePage(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        centerTitle: true,
        title: Text(
          'CampusPantry',
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
              leading: Icon(Icons.history_edu),
              title: Text('ORDER HISTORY'),
              titleTextStyle: TextStyle(
                letterSpacing: 2,
                fontFamily: 'SpecialGhotic',
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(context, '/OrderHistory');
              },
            ),

            //Donate
            // ListTile(
            //   leading: Icon(Icons.card_giftcard),
            //   title: Text('D O N A T I O N'),
            //   titleTextStyle: TextStyle(
            //     fontFamily: 'SpecialGhotic',
            //     color: Colors.black,
            //   ),
            // ),

            //Help AND FAQ
            ListTile(
              leading: Icon(Icons.help_outline_rounded),
              title: Text(' H E L P  &  F A Q S'),
              titleTextStyle: TextStyle(
                fontFamily: 'SpecialGhotic',
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(context, '/helppage');
              },
            ),

            //About
            ListTile(
              leading: Icon(Icons.info_outline_rounded),
              title: Text('P R I V A C Y  P O L I C Y'),
              titleTextStyle: TextStyle(
                fontFamily: 'SpecialGhotic',
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(context, '/privacypolicy');
              },
            ),

            //Logout
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('L O G O U T'),
              titleTextStyle: TextStyle(
                fontFamily: 'SpecialGhotic',
                color: Colors.black,
              ),
              onTap: () => logout(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () {
          Navigator.pushNamed(context, '/chatbotpage'); 
        },
        elevation: 12,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: Icon(Icons.chat_bubble_outline, color: Colors.white),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        currentIndex: _selectedindex,
        onTap: _navigationBottomBar,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Theme.of(context).colorScheme.inversePrimary,
        selectedItemColor: Colors.amberAccent,
        items: [
          //Home
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,

            ),

            label: '',
          ),

          //Food
          BottomNavigationBarItem(
            icon: Icon(
              Icons.food_bank_outlined,

            ),
            label: '',
          ),

          //Scan
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt_outlined,
             
            ),

            label: '',
          ),

          //Borrow
          BottomNavigationBarItem(
            icon: Icon(
              Icons.handshake_outlined,
         
            ),
            label: '',
          ),

          //Profile
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.person_2_outlined,
          //     color: Theme.of(context).colorScheme.inversePrimary,
          //   ),
          //   label: '',
          // ),
        ],
      ),
      
    );
  }
}