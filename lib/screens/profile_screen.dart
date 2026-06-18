import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height: 30),

             CircleAvatar(
              radius: 60,
              child: Icon(
                Icons.person,
                size: 60,
              ),
            ),

             SizedBox(height: 16),

             Text(
              "Jyoti Mandal",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

             SizedBox(height: 8),

            Text(
              "jyoti@gmail.com",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

             SizedBox(height: 30),

            Card(
              margin:  EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: ListTile(
                leading:  Icon(Icons.person_outline),
                title:  Text("Edit Profile"),
                trailing:  Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),

            Card(
              margin:  EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: ListTile(
                leading:  Icon(Icons.notifications_outlined),
                title:  Text("Notifications"),
                trailing:  Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),

            Card(
              margin: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: ListTile(
                leading:  Icon(Icons.lock_outline),
                title: Text("Privacy"),
                trailing:  Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),

            Card(
              margin: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: ListTile(
                leading: Icon(Icons.settings_outlined),
                title:  Text("Settings"),
                trailing:  Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),

             SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:  Icon(Icons.logout),
              label:  Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}