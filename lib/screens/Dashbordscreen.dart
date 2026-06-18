import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Colors/custom_colors.dart';
import 'package:untitled/providers/home_provider.dart';
import 'package:untitled/screens/profile_screen.dart';
import 'package:untitled/widgets/calendar.dart';
import 'package:untitled/widgets/habitcard.dart';

class Dashbordscreen extends StatefulWidget {
  Dashbordscreen({super.key});

  @override
  State<Dashbordscreen> createState() => _DashbordscreenState();
}

class _DashbordscreenState extends State<Dashbordscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                onChanged: (value){
                  Provider.of<HomeProvider>(
                    context,
                    listen: false,
                  ).runFilter(value);
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
                  return  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.foundTasks.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                            key: ValueKey(index),
                            endActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    provider.delete(index);
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    //vertical: 10,
                                  ),
                                  backgroundColor: Colors.red.shade300,
                                  foregroundColor:Colors.black,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                               // Icon(Icons.edit),
                              ],
                            ),
                         child: Card(
                          color: CustomColors.surface( context),
                          shadowColor:CustomColors.shadow(context),
                          margin: EdgeInsetsGeometry.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(provider.foundTasks[index].title),
                            subtitle: Text(provider.foundTasks[index].description),
                            trailing:Text(provider.foundTasks[index].date),
                            //leading: Text(provider.foundTasks[index].time),
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
