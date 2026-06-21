import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeProvider extends ChangeNotifier {
  List<dynamic> _data = [];

  List<dynamic> get data => _data;


  TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;

  TextEditingController _datecontroller = TextEditingController();

  TextEditingController get datecontroller => _datecontroller;

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController get descriptionController => _descriptionController;

  TextEditingController _timecontroller = TextEditingController();

  TextEditingController get timecontroller => _timecontroller;

  void toast() {
    Fluttertoast.showToast(msg: 'Task created Successfuly');
  }

  Uint8List? profileImage;

  Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker img = ImagePicker();

    XFile? file = await img.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    return null;
  }

  Future<void> selectImage() async {
    profileImage = await pickImage(ImageSource.gallery);
    notifyListeners();
  }

  // List<dynamic> get todayHabits {
  //   final now = DateTime.now();
  //
  //   return _data.where((task) {
  //     String? date = task['date'];
  //
  //     if (date == null || date.isEmpty) {
  //       return false;
  //     }
  //
  //     try {
  //       List<String> parts = date.split('/');
  //
  //       if (parts.length != 3) {
  //         return false;
  //       }
  //
  //       int day = int.parse(parts[0]);
  //       int month = int.parse(parts[1]);
  //       int year = int.parse(parts[2]);
  //
  //       return day == now.day &&
  //           month == now.month &&
  //           year == now.year;
  //     } catch (e) {
  //       return false;
  //     }
  //   }).toList();
  // }

  // void toggleTask(Map<String>,dynamic) {
  //   task['isCompleted']=!(task['isCompleted']?? false);
  //   notifyListeners();
  // }
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
  int selectedIndex = DateTime
      .now()
      .weekday - 1;
  DateTime selectedDate = DateTime.now();

  List<Map<String, dynamic>> habits = [
    {
      "title": "Sleep",
      "description": "Sleep for 8 hours",
      "date": "14/06/2026",
      "time": "9:00",
    },
    {
      "title": "Drink Water",
      "description": "Drink 2 liters of water",
      "date": "14/06/2026",
      "time": "7:30",
    },
  ];
  List<dynamic> _foundTasks = [];

  List<dynamic> get foundTasks => _foundTasks;

  HomeProvider() {
    _foundTasks = List.from(data);
  }


  void runFilter(String enteredKeyword) {
    if (enteredKeyword
        .trim()
        .isEmpty) {
      _foundTasks = List.from(data);
    } else {
      _foundTasks = data.where((task) {
        return task['title'].toString().toLowerCase()
            .contains(enteredKeyword.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  //delete
  void delete(Map<String, dynamic> task) {
    _data.remove(task);
    runFilter('');
    notifyListeners();
  }

  //add habit
  void addHabit(String title,
      String description,
      String date,
      String time,) {
    _data.add(
        {
          "title": title,
          "description": description,
          "date": date,
          "time": time,
        });
    runFilter('');
    notifyListeners();
  }

  void editHabit(int index,
      String title,
      String description,
      String date,
      String time,) {
    _data[index] = {
      "title": title,
      "description": description,
      "date": date,
      "time": time,
    };

    runFilter('');
    notifyListeners();
  }


  void clearControllers() {
    controller.clear();
    descriptionController.clear();
    datecontroller.clear();
    timecontroller.clear();
  }

  void changeDate(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void updateSelectDate(DateTime date) {
    selectedDate = date;
    datecontroller.text = '${date.day}/${date.month}/${date.year}';
    notifyListeners();
  }

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }


  Future<void> getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://6a34f1e68248ee962fa5d77c.mockapi.io/api/jyoti/todo'));
    _data = jsonDecode(response.body);
    _foundTasks = List<dynamic>.from(_data);
    notifyListeners();
  }

  Future<void> postData() async {
    http.Response response = await http.post(Uri.parse('https://6a34f1e68248ee962fa5d77c.mockapi.io/api/jyoti/todo'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(
          {
            'title': controller.value.text,
            'description': descriptionController.value.text,
            'date': datecontroller.value.text,
            'time': timecontroller.value.text,
          }
      ),
    );
    print(response.body);
    notifyListeners();
  }

  Future<dynamic> deleteData( String id) async {
    http.Response response = await http.delete(Uri.parse('https://6a34f1e68248ee962fa5d77c.mockapi.io/api/jyoti/todo/$id'));
  }
  notifyListeners();
}







// class Habit {
//   final String title;
//   final String description;
//   final String date;
//   final String time;
//   bool isCompleted;
//
//
//   Habit({
//     required this.title,
//     required this.description,
//     required this.date,
//     required this.time,
//     this.isCompleted = false,
//
//   });
//}

