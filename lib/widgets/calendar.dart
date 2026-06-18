import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Colors/custom_colors.dart';
import 'package:untitled/providers/home_provider.dart';

class Calender extends StatelessWidget {
  Calender({super.key});
  List<DateTime> getCurrentWeeks() {
    DateTime today = DateTime.now();
    DateTime monday = today.subtract(Duration(days: today.weekday - 1));
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final dates = getCurrentWeeks();
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final date = dates[index];
              //bool isSelected=provider.selectedDate==date;
              return GestureDetector(
                onTap: () {
                  provider.changeDate(index);
                },
                child: Container(
                  height: 30,
                  width: 70,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: provider.selectedIndex == index
                        ? CustomColors.subtitle(context)
                        : CustomColors.surface(context),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.shadow(context),
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EEE').format(date),
                        style: TextStyle(
                          color: provider.selectedIndex == index
                              ? CustomColors.primary(context)
                              : Colors.blueGrey.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        DateFormat('dd').format(date),
                        style: TextStyle(
                          color: provider.selectedIndex == index
                              ? CustomColors.primary(context): Colors.blueGrey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
