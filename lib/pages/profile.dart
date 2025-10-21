import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
   String ? name;
   String ? email;
    void initState() {
    super.initState();
    loaduserdata();
  }

  Future<void> loaduserdata() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
     name = prefs.getString('name') ?? 'User';
     email =prefs.getString('email')?? 'EmailUser@gmail.com';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'CalSans'
          ),
        ),
      ),
    backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body: ListView(
        
        padding: EdgeInsets.all(12),
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.amber[600],
                child: Icon(Icons.person,
                color: Colors.white,
                size: 45,
                ),
               
              ),
              SizedBox(height: 10),
              Text(
                '${name}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${email}'
              ),

            ],
          ),
          SizedBox(
            height: 25,
          ),
          ...List.generate(ListTileItems.length, 
          (index){
            final subtab = ListTileItems[index];
            return Card(
              elevation: 4,
              shadowColor: Colors.black26,
              child: ListTile(
                leading: Icon(subtab.icon),
                title: Text(subtab.title),
                trailing: Icon(Icons.chevron_right_rounded),
                onTap: () {
                  if (subtab.title == "Order History"){
                    Navigator.pushNamed(context, '/OrderHistory');
                  }
                },
              


              ),
            );
          }
          )
        ],
      ),
    );
  }

  
}
class CustomListTile {
  final IconData icon;
  final String title;

  CustomListTile({
    required this.icon,
    required this.title,
  });
}

List <CustomListTile> ListTileItems =[
  CustomListTile(icon: Icons.history ,title: "Order History",),
  CustomListTile(icon: Icons.handshake ,title: "Donation Summary"),
  CustomListTile(icon: Icons.settings ,title: "Settings"),
  CustomListTile(icon: Icons.logout ,title: "Log-Out"),

];



