import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Kosmas"),
            accountEmail: Text("kosmasfn@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              // Close the drawer and navigate to the home screen
              Navigator.pop(context);
              // Perform any navigation here
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Profile screen (for example)
            },
          ),
          // Add more list items here
        ],
      ),
    );
  }
}
