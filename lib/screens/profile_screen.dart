import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Colors/custom_colors.dart';
import 'package:untitled/providers/home_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/screens/Introscreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Consumer<HomeProvider>(builder: (context,provider,_){
        return  SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: CustomColors.shadow(context),
                    backgroundImage:provider.profileImage!=null?
                    MemoryImage(provider.profileImage!):AssetImage('assets/OIP (5).jpeg') as ImageProvider,
                  ),
                  Positioned(
                    bottom: -5,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomColors.subtitle(context),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                        provider.selectImage();
                        },
                        icon:  Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
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
                  fontSize: 16,
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
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
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
                  trailing:  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: () {},
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ListTile(
                  leading: Icon(Icons.lock_outline),
                  title:  Text("Privacy"),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: () {},
                ),
              ),


              Card(
                margin:  EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ListTile(
                  leading:  Icon(Icons.settings_outlined),
                  title:  Text("Settings"),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: () {},
                ),
              ),

              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder:(_)=>Homescreen ()));
                },
                icon: Icon(Icons.logout),
                label: Text(
                  "Logout",
                  style: TextStyle(
                    color: CustomColors.text(context),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        );
      },

      ),
    );
  }
}