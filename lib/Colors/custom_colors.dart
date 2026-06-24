// import 'package:flutter/material.dart';
// class CustomColors {
//   CustomColors._();
//   static bool isDark (BuildContext context)=>Theme.of(context).brightness==Brightness.dark;
//
// static Color appbar( BuildContext context)=> isDark(context)? const Color(0XFF121212): const Color(0xFFCE93D8);
// static Color  backgroundColor(BuildContext context)=>isDark(context)? const Color(0xFF424242): const Color(0xFFCE93D8);
// static Color primary(BuildContext context)=>isDark(context)? const Color(0xFF303030):Color(0xFFFFFFFF); //colors.white
// static Color primaryPurple(BuildContext context)=>isDark(context)? const Color(0xFF424242):Color(0xFFBB86FC); //purple.shade200
// static Color darkPurple(BuildContext context)=>isDark(context)? const Color(0xFF424242):Color(0xFF7E57C2);
// static Color text (BuildContext context)=>isDark(context)? const Color(0xFF424242):Color(0xFF121212);
// static Color shadow(BuildContext context)=>isDark(context)? const Color(0xFF424242):Color(0xFFBA68C8);//purple.shade300
//
// }
//
import 'package:flutter/material.dart';

class CustomColors {
  CustomColors._();

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  // Background
  static Color background(BuildContext context) =>
      isDark(context)
          ?  Color(0xFF121212)
          :  Color(0xFFF5F5F5);

  // Cards, Containers
  static Color surface(BuildContext context) =>
      isDark(context)
          ?  Color(0xFF1E1E1E)
          :  Color(0xFFFFFFFF);

  // AppBar
  static Color appBar(BuildContext context) =>
      isDark(context)
          ?  Color(0xFF1E1E1E)
          :  Color(0xFF7E57C2);

  // Main Primary Color
  static Color primary(BuildContext context) =>
      isDark(context)
          ?  Color(0xFF424242)
          :  Color(0xFF7E57C2);

  // Text
  static Color text(BuildContext context) =>
      isDark(context)
          ?  Color(0xFFFFFFFF)
          :  Color(0xFF212121);

  // Sub Text
  static Color subtitle(BuildContext context) =>
      isDark(context)
          ?  Color(0xFFEEEEEE)
          :  Color(0xFFE1BEE7);

  // Border
  static Color border(BuildContext context) =>
      isDark(context)
          ?  Color(0xFF424242)
          : Color(0xFFE0E0E0);

  // Shadow
  static Color shadow(BuildContext context) =>
      isDark(context)
          ? Colors.white
          : Colors.purple.shade200;

  static Color category(BuildContext context) =>
      isDark(context)
          ? Color(0xFF424242)
          : Colors.blue.shade300;

}