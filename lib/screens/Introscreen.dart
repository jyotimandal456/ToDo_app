import 'package:flutter/material.dart';
import 'package:untitled/Colors/custom_colors.dart';
import 'package:untitled/screens/Dashbordscreen.dart';
import 'package:untitled/screens/mainscreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF2E7F5),
      body: Container(
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img8.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        padding:  EdgeInsets.symmetric(vertical: 16,horizontal: 16),
        child: SafeArea(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.start,
            children: [
              // SizedBox(height: 20),
              Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height:600),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  CustomColors.surface(context),
                    foregroundColor: CustomColors.text(context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder:(_)=>Mainscreen()));
                  },
                  child:  Text(
                    "Explore",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}