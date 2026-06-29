import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Colors/custom_colors.dart';
import 'package:untitled/screens/Dashbordscreen.dart';
import 'package:untitled/screens/mainscreen.dart';

import '../providers/home_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final HomeProvider sessionProvider = Provider.of<HomeProvider>(context,listen: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background(context),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            padding:  EdgeInsets.all(20),
            decoration: BoxDecoration(
              color:CustomColors.surface(context),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color:CustomColors.shadow(context),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Icon(
                  Icons.person,
                  size: 80,
                  color: CustomColors.appBar(context),
                ),
               SizedBox(height: 10),

               Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.appBar(context),
                  ),
                ),

                 SizedBox(height: 20),

                TextField(
                  controller: sessionProvider.usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon:  Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  controller: sessionProvider.passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon:  Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                ),
                 SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        sessionProvider.login(
                            sessionProvider.usernameController.value.text,
                            sessionProvider.passwordController.value.text, context);
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:CustomColors.appBar(context),
                      padding:  EdgeInsets.symmetric(vertical: 15),
                    ),
                    child:  Text(
                      "Login",
                      style: TextStyle(color: Colors.white,
                      fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}