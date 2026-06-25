import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Colors/custom_colors.dart';
import 'package:untitled/providers/home_provider.dart';
import 'package:untitled/screens/Introscreen.dart';
import 'package:untitled/screens/profile_screen.dart';
import 'package:untitled/widgets/calendar.dart';
import 'package:untitled/widgets/habitcard.dart';

import 'Task_screen.dart';

class Dashbordscreen extends StatefulWidget {
  Dashbordscreen({super.key});

  @override
  State<Dashbordscreen> createState() => _DashbordscreenState();
}

class _DashbordscreenState extends State<Dashbordscreen> {
 @override
  void initState() {
    final HomeProvider hp=Provider.of<HomeProvider>(context,listen: false);
    super.initState();
    hp.getData();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> Homescreen()));
        }, icon:Icon(Icons.arrow_back)),
        titleSpacing: 16,
        centerTitle: false,
        backgroundColor:CustomColors.appBar(context),
        title: Text('Hello!',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        ),
        actions: [
          Consumer<HomeProvider>(
            builder: (context,provider,_){
              return  IconButton(
                onPressed: (){
                 provider.toggleTheme();
                },
              icon:Icon(provider.isDarkMode?
              Icons.light_mode:Icons.dark_mode),
              );
            },
          ),
          SizedBox(width:15),
          Consumer<HomeProvider>(builder: (context,provider,_){
            return  Padding(
              padding:EdgeInsetsGeometry.only(right: 15),
              child:GestureDetector(
                onTap:(){
                  provider.selectImage();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(),));
                },

                child:   CircleAvatar(
                  backgroundColor: Colors.purple.shade50,
                  backgroundImage:provider.profileImage!=null?
                  MemoryImage(provider.profileImage!):AssetImage('assets/OIP (5).jpeg') as ImageProvider,
                  radius: 16,
                 // child: Icon(Icons.person),
                ),
              ),

            );
          },

          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/img7.jpeg'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // SizedBox(height: 20),
             // Calender(),
              SizedBox(height: 16),
              TextFormField(
                style: TextStyle(
                  color: CustomColors.text(context),
                ),
                onChanged: (value) {
                  Provider.of<HomeProvider>(context, listen: false).runFilter(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search By name',
                  prefixIcon: Icon(Icons.search,
                  color: CustomColors.subtitle(context),
                  ),
                  filled: true,
                  fillColor: CustomColors.surface(context),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Calender(),
              SizedBox(height: 16),
              Text(
                "Tasks",
                style: TextStyle(fontSize: 28,
                    fontWeight: FontWeight.bold,
                color: CustomColors.text(context)),
              ),
              SizedBox(height: 16),
              Consumer<HomeProvider>(
                builder: (context,provider,_){
                  return Expanded(
                    child: ListView.builder(
                      itemCount: provider.foundTasks.length,
                      itemBuilder: (context, index) {
                        final task = provider.foundTasks[index];
                        final originalIndex = provider.data.indexOf(task);
                        return Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion:  StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) async{
                                     final task = provider.foundTasks[index];
                                    // await provider.updateData(task['id']);
                                  provider.controller.text = task['title']?.toString() ?? '';
                                  provider.descriptionController.text = task['description']?.toString() ?? '';
                                  provider.datecontroller.text = task['date']?.toString() ?? '';
                                  provider.startTimecontroller.text = task['startTime']?.toString() ?? '';
                                  provider.endTimecontroller.text = task['endTime']?.toString() ?? '';
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskScreen(editIndex: index,taskId:task['id']),

                                    ),
                                  );
                                },
                                icon: Icons.edit,
                                label: 'Edit',
                                backgroundColor:CustomColors.surface(context),
                                foregroundColor: Colors.green,
                              ),
                              SlidableAction(
                                onPressed: (context) async {
                                  final task = provider.foundTasks[index];
                                  showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      content: Text('Are you sure?',
                                      style: TextStyle(fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                      ),
                                      actions: [
                                        TextButton(onPressed: (){
                                        Navigator.pop(context);
                                        }, child:Text('Cancel'),
                                        ),
                                        SizedBox(width: 10,),
                                        TextButton(onPressed: () async {
                                          final task = provider.foundTasks[index];
                                           await provider.deleteData(task['id']);
                                          Navigator.pop(context);

                                        },
                                            child:Text('Sure'))
                                      ],
                                    );
                                  });

                                },
                                backgroundColor: CustomColors.surface(context),
                                icon: Icons.delete,
                                label: 'Delete',
                                foregroundColor: Colors.red,
                              ),
                            ],
                          ),
                          child: Card(
                            shadowColor: CustomColors.shadow(context),
                            color: CustomColors.surface(context),
                            child:ListTile(
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
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
