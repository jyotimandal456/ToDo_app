import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Colors/custom_colors.dart';
import '../providers/home_provider.dart';

class TaskScreen extends StatelessWidget {
  final int? editIndex;

  TaskScreen({super.key,
    this.editIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background(context),
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, provider, _) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
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
                          icon: Icon(Icons.arrow_back_ios),
                        ),

                        Text(
                          editIndex == null
                              ? "Create Task"
                              : "Edit Task",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () {
                            provider.pickTime(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    if (provider.timecontroller.text.isNotEmpty)
                      Center(
                        child: Text(
                          "Time: ${provider.timecontroller.text}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    SizedBox(height: 20),
                    CalendarDatePicker(
                      initialDate: provider.selectedDate,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2030),
                      onDateChanged: provider.updateSelectDate,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: provider.controller,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        filled: true,
                        fillColor: CustomColors.surface(context),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: provider.descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Task Description...',
                        filled: true,
                        fillColor: CustomColors.surface(context),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.shadow(context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () async {
                        if (provider.controller.text.trim().isEmpty) {
                        return;
                        }
                        if (editIndex == null) {
                         await provider.postData(context);
                        } else {
                       provider.editHabit(
                      editIndex!,
                       provider.controller.text.trim(),
                       provider.descriptionController.text.trim(),
                       provider.datecontroller.text.trim(),
                       provider.timecontroller.text.trim(),
                       );
                       }provider.clearControllers();
                       Navigator.pop(context);
                        },
                          child:Text(
                            editIndex == null ? "Create Task" : "Update Task",
                            style: TextStyle(
                              color: CustomColors.surface(context),
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}