import 'package:flutter/material.dart';
import 'package:untitled/Colors/custom_colors.dart';
import 'package:untitled/providers/home_provider.dart';

class Habitcard extends StatelessWidget {
  final Habit habit;

  const Habitcard({
    super.key,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: CustomColors.primary(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            habit.date,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

           SizedBox(height: 8),

          Text(
            habit.description,
            style:  TextStyle(
              fontSize: 14,
            ),
          ),

          SizedBox(height: 8),

          Text(
            habit.title,
            style:TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}