import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/home_provider.dart';
import 'package:untitled/screens/Dashbordscreen.dart';
import 'package:untitled/screens/Introscreen.dart';
import 'package:untitled/screens/loginScreen.dart';
import 'package:untitled/screens/mainscreen.dart';

void main() {
  runApp( ChangeNotifierProvider(create: (_)=>HomeProvider(),
  child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder:(context,provider,_){
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
            themeMode: provider.isDarkMode? ThemeMode.dark:ThemeMode.light,
             theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const Homescreen(),
        );
      },
    );
  }
}


