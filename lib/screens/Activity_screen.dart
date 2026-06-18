import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Colors/custom_colors.dart';
import '../providers/home_provider.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:CustomColors.background(context),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
             SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tasks",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.text(context),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: provider.todayHabits.isEmpty
                    ?  Center(
                  child: Text(
                    "No Tasks For Today",
                    style: TextStyle(
                      fontSize: 18,
                      color:CustomColors.text(context),
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: provider.todayHabits.length,
                  itemBuilder: (context, index) {
                    final habit = provider.todayHabits[index];

                    return Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: CheckboxListTile(
                        value: habit.isCompleted,
                        onChanged: (_) {
                          provider.toggleTask(habit);
                        },
                        title: Text(habit.title),
                        subtitle: Text(
                          "${habit.description}/${habit.time}",
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}