import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Colors/custom_colors.dart';
import '../providers/home_provider.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     backgroundColor: CustomColors.background(context),
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, provider, _) {
            return SingleChildScrollView(
              padding:  EdgeInsets.symmetric(
               horizontal: 10,
                vertical:10,
              ),
              child: Container(
                padding:  EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // gradient: LinearGradient(colors: [
                  //   Color(0xFF7E57C2),
                  //   Color(0xFFBB86Fc),
                  // ],

                    //
                 // ),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon:Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                            Text(
                          'Create Task',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () async {
                            await provider.pickTime(context);
                          },
                        ),
                      ],
                    ),

                    if (provider.timecontroller.text.isNotEmpty)
                      Center(
                        child: Text(
                          "Time: ${provider.timecontroller.text}",
                          style:  TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    // IconButton(
                        //   icon:  Icon(Icons.access_time),
                        //   onPressed: () async {
                        //     TimeOfDay? picked = await showTimePicker(
                        //       context: context,
                        //       initialTime: TimeOfDay.now(),
                        //     );
                        //
                        //     if (picked != null) {
                        //       context.read<HomeProvider>().setTime(picked);
                        //     }
                        //   },
                        // )



                    SizedBox(height: 20),
                    CalendarDatePicker(
                      initialDate: provider.selectedDate,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2030),
                      onDateChanged: provider.updateSelectDate,
                    ),

                    SizedBox(height: 20),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                      //  color:CustomColors.primary(context),
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child:  Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color:CustomColors.primary(context  ),
                            size: 35,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Text('Idea',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight:
                                FontWeight.w500,
                                color:CustomColors.text(context),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ),

                     SizedBox(height: 20),
                    TextFormField(
                      controller: provider.controller,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        filled: true,
                        fillColor:CustomColors.surface(context),
                        border:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller:
                      provider.descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText:
                        'Task Description...',
                        filled: true,
                        fillColor: CustomColors.surface(context),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:CustomColors.shadow(context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          if (provider.controller.text.trim().isNotEmpty) {
                            provider.addHabit(provider.controller.text.trim(),
                              provider.descriptionController.text.trim(),
                              provider.datecontroller.text.trim(),
                              provider.timecontroller.text.trim(),
                            );

                            provider.controller.clear();
                            provider.descriptionController.clear();
                            provider.datecontroller.clear();
                           provider.toast();
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Create Task',
                          style: TextStyle(
                            color:CustomColors.surface(context),
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                   ]
                ),
            ),
            );
          },
        ),
      ),
    );
  }
}