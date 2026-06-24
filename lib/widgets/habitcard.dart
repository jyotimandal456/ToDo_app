import 'package:flutter/material.dart';
import 'package:untitled/Colors/custom_colors.dart';

class Habitcard extends StatelessWidget {
  final Map<String, dynamic> habit;

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
            habit['habit'] ?? '',
            style:  TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8),

          Text(
            habit['description'] ?? '',
            style: TextStyle(fontSize: 14),
          ),

          SizedBox(height: 12),

          Text(
            habit['title'] ?? '',
            style:  TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

        SizedBox(height: 10),

          Container(
            padding:EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: CustomColors.surface(context),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              habit['category'] ?? 'General',
              style: TextStyle(
                color: CustomColors.subtitle(context),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}