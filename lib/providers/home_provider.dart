import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;

  TextEditingController _datecontroller = TextEditingController();
  TextEditingController get datecontroller => _datecontroller;

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController get descriptionController => _descriptionController;

  TextEditingController _timecontroller =TextEditingController();
  TextEditingController get timecontroller=>_timecontroller;

  void toast(){
   Fluttertoast.showToast(msg: 'Task created Successfuly');
  }

  Uint8List? profileImage;
  Future<Uint8List?> pickImage(ImageSource source)async{
    final ImagePicker img=ImagePicker();

    XFile? file =await img.pickImage(source: source);
    if(file!=null){
      return await file.readAsBytes();
    }
    return null;
  }
  Future<void> selectImage()async{
    profileImage =await pickImage(ImageSource.gallery);
    notifyListeners();
  }

  List<Habit> get todayHabits {
   // DateTime today = DateTime.now();

    String selected = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';

    return habits.where((habit) {
      return habit.date == selected;
    }).toList();
  }

  void toggleTask(Habit habit) {
    habit.isCompleted=!habit.isCompleted;
    notifyListeners();
  }
  Future<void> pickTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      timecontroller.text = picked.format(context);
      notifyListeners();
    }
  }
  //int currentIndex = 0;
  int selectedIndex = DateTime.now().weekday - 1;
 DateTime selectedDate=DateTime.now();
  final List<Habit> habits = [
    Habit(
      title: 'Sleep',
      description: 'Sleep for 8 hours',
      date: '14/06/2026',
      time: '9:00'
    ),
    Habit(
      title: 'Drink Water',
      description: 'Drink 2 liters of water',
      date: '14/06/2026',
      time:'7:30'
    ),
    Habit(
      title: 'Exercise',
      description: 'Workout for 45 minutes',
      date: '14/06/2026',
      time:'8:00'
    ),
    Habit(
      title: 'Reading',
      description: 'Read for 30 minutes',
      date: '14/06/2026',
      time:'9:00'
    ),
  ];
  List<Habit> foundTasks = [];

  HomeProvider() {
    foundTasks =List.from(habits);
  }
  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      foundTasks = List.from(habits);
    } else {
      foundTasks = habits.where((habit) {
        return habit.title
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  void delete(int index) {
    habits.removeAt(index);
    runFilter('');
  }

  void addHabit(
      String title,
      String description,
      String date,
      String time,
      ) {
    habits.add(
      Habit(
        title: title,
        description: description,
        date: date,
        time: time,
      ),
    );
    runFilter('');
  }

  // void changeIndex(int index) {
  //   currentIndex = index;
  //   notifyListeners();
  // }

  void changeDate(int index) {
    selectedIndex = index;
    notifyListeners();
  }

    void  updateSelectDate(DateTime date)  {
        selectedDate=date;
      datecontroller.text = '${date.day}/${date.month}/${date.year}';
      notifyListeners();
    }
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  }



class Habit {
  final String title;
  final String description;
  final String date;
  final String time;
  bool isCompleted;


  Habit({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.isCompleted = false,

  });
}

