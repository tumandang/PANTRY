import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Student's Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "student1234@d8938.com"

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
  CustomListTile(icon: Icons.history ,title: "Order History"),
  CustomListTile(icon: Icons.handshake ,title: "Donation Summary"),
  CustomListTile(icon: Icons.settings ,title: "Settings"),
  CustomListTile(icon: Icons.logout ,title: "Log-Out"),

];



