import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Colors/custom_colors.dart';
import '../providers/home_provider.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background(context),
      appBar: AppBar(
        backgroundColor: CustomColors.appBar(context),
        title: Text("Tasks",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: CustomColors.text(context),
          ),
        ),
      ),

      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final tasks = provider.foundTasks.isNotEmpty ? provider.foundTasks : provider.data;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return Card(
                color: CustomColors.surface(context),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Text(task['time']?.toString() ?? ''),
                  title: Text(task['title']?.toString() ?? ''),
                  subtitle: Text(task['description']?.toString() ?? ''),
                  trailing: Text(task['date']?.toString() ?? ''),
                ),
              );
            },
          );
        },
      ),
    );
  }
}