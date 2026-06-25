import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Colors/custom_colors.dart';
import 'package:untitled/screens/mainscreen.dart';
import '../providers/home_provider.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background(context),
      appBar: AppBar(
        leading: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Mainscreen()));
        }, icon:Icon(Icons.arrow_back)),
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
                shadowColor: CustomColors.shadow(context),
                color: CustomColors.surface(context),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  isThreeLine: true,
                  title: Text(provider.foundTasks[index]['title']?.toString() ?? '',
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${provider.foundTasks[index]['startTime'] ?? ''} - ${provider.foundTasks[index]['endTime'] ?? ''}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(provider.foundTasks[index]['description']?.toString() ?? '',
                      ),
                    ],
                  ),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: CustomColors.shadow(context),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(provider.foundTasks[index]['category']?.toString() ?? 'General',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}