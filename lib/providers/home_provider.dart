import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as stroage;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  String _selectedCategory = "work";
  String get selectedCategory => _selectedCategory;

  String? _startTime;
  String? _endTime;
  String? get startTime => _startTime;
  String? get endTime => _endTime;

  TextEditingController _startTimecontroller= TextEditingController();
  TextEditingController  get startTimecontroller => _startTimecontroller;

  TextEditingController _endTimecontroller=TextEditingController();
  TextEditingController get endTimecontroller => _endTimecontroller;


  // void toast() {
  //   Fluttertoast.showToast(msg: 'Task created Successfuly');
  // }

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
  void pickStartTime(BuildContext context) async {
    DateTime? dateTime = await showOmniDateTimePicker(context: context,
      type: OmniDateTimePickerType.time,
      is24HourMode: false,
    );

    if (dateTime != null) {
      _startTime = DateFormat('hh:mm a').format(dateTime);
      _startTimecontroller.text = _startTime!;
    }
    notifyListeners();
  }

  void pickEndTime(BuildContext context) async {
    DateTime? picked = await showOmniDateTimePicker(
      context: context,
      type: OmniDateTimePickerType.time,
    );

    if (picked != null) {
      _endTime = DateFormat('hh:mm a').format(picked);
      _endTimecontroller.text = _endTime!;
    }
    notifyListeners();
  }

  //int currentIndex = 0;
  int selectedIndex = DateTime.now().weekday - 1;
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
    if (enteredKeyword.trim().isEmpty) {
      _foundTasks = List.from(_data);
    } else {
      _foundTasks = data.where((task) {
        return task['title'].toString().toLowerCase().contains(enteredKeyword.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  //delete
  // void delete(Map<String, dynamic> task) {
  //   _data.remove(task);
  //   runFilter('');
  //   notifyListeners();
  // }

  //add habit
  void addHabit(
      String title,
      String description,
      String date,
      String start,
      String end,
      ) {
    _data.add(
        {
          "title": title,
          "description": description,
          "date": date,
          "start":start,
          "end":end,

        });
    runFilter('');
    notifyListeners();
  }

  // void editHabit(int index,
  //     String title,
  //     String description,
  //     String date,
  //     String time,
  //     String category,
  //     ) {
  //   _data[index] = {
  //     "title": title,
  //     "description": description,
  //     "date": date,
  //     "time": time,
  //     "category":category,
  //   };
  //
  //   runFilter('');
  //   notifyListeners();
  // }


  void clearControllers() {
    controller.clear();
    descriptionController.clear();
    datecontroller.clear();
    startTimecontroller.clear();
    endTimecontroller.clear();
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

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }


  Future<void> getData() async {
    http.Response response = await http.get(Uri.parse('https://6a34f1e68248ee962fa5d77c.mockapi.io/api/jyoti/todo'));
    _data = jsonDecode(response.body);
    _foundTasks = List<dynamic>.from(_data);
    notifyListeners();
    print(_foundTasks);

  }

  Future<void> postData(BuildContext context) async {
    http.Response response = await http.post(Uri.parse('https://6a34f1e68248ee962fa5d77c.mockapi.io/api/jyoti/todo'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({
        "title": controller.text.trim(),
        "description": descriptionController.text.trim(),
        "date": datecontroller.text.trim(),
        // "time": timecontroller.text.trim(),
        "startTime": startTimecontroller.text.trim(),
        "endTime": endTimecontroller.text.trim(),
        "category": selectedCategory,
      }),
      );
    if(response.statusCode==200){
      print('response.statuscode');
     // _data.add(jsonDecode(response.body));
     // _foundTasks=List.from(_data);
     //  ScaffoldMessenger.of(context).showSnackBar(
     //    SnackBar(
     //      padding: EdgeInsets.symmetric(
     //        horizontal: 10,
     //        vertical: 10,
     //      ),
     //      backgroundColor: CustomColors.surface(context),
     //      content: Row(
     //        children: [
     //          Icon(Icons.thumb_up, color: Colors.blue),
     //          SizedBox(width: 10),
     //          Expanded(
     //            child: Text('Task Created Successfully',
     //              style: TextStyle(
     //                color:CustomColors.text(context),
     //              ),
     //            ),
     //          ),
     //        ],
     //      ),
     //    ),
     //  );
      notifyListeners();
    }

  }

  Future<bool> deleteData(String id) async {
    final response = await http.delete(
      Uri.parse('https://6a34f1e68248ee962fa5d77c.mockapi.io/api/jyoti/todo/$id',),);

    if (response.statusCode == 200) {
      _data.removeWhere((task) => task['id'] == id);
      _foundTasks.removeWhere((task) => task['id'] == id);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> updateData(BuildContext context,
      String id,
      String title,
      String description,
      String date,
      String category,
      String startTime,
      String endTime,

      ) async {
    http.Response response = await http.put(
      Uri.parse('https://6a34f1e68248ee962fa5d77c.mockapi.io/api/jyoti/todo/$id',),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'description': description,
        'date': date,
        'category':category,
        'startTime':startTime,
        'endTime':endTime,

      }),
    );
    if (response.statusCode == 200) {await getData();
      notifyListeners();
      return true;
    }else{
      return false;
    }
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
  // static final SessionController _instance=SessionController();
  // static SessionController get instance =>_instance;
  //
  // String? userId;
  // String? token;
  // DateTime? expiryData;
  //
  // void setSession(String userId,String token,DateTime expiryData) async {
  //   this.userId;
  //   this. token;
  //   this.expiryData;
  //
  //   const storage = FlutterSecureStorage();
  //   await storage.write(key: 'userId', value: userId);
  //   await storage.write(key: 'expiryData', value: expiryData.toIso8601String());
  // }
}

class SessionController {
  static final SessionController _instance=SessionController();
  static SessionController get instance =>_instance;

  String? userId;
  String? token;
  //DateTime? expiryDate;

  void setSession(String userId,String token,DateTime expiryData) async {
    this.userId;
    this. token;
    //this.expiryDate;

    const storage = FlutterSecureStorage();
    await storage.write(key: 'userId', value: userId);
   // await storage.write(key: 'expiryDate', value: expiryData.toIso8601String());
  }
  Future <void> LoadSession() async{
     const storage =FlutterSecureStorage();
     final response = await Future.wait([
       storage.read(key: 'userId'),
       storage.read(key: 'token'),
      // storage.read(key: 'expiryDate')
     ]);
     userId =response[0];
     token=response[1];
     // String? expiryDateString =response[2];
     // if(expiryDateString!=null){
     //   expiryDate=DateTime.parse(expiryDateString);
     // }
  }
  void clearSession() async{
    userId =null;
    token=null;
    //expiryDate=null;

    const storage = FlutterSecureStorage();
    await Future.wait([
      storage.delete(key: 'userId'),
      storage.delete(key: 'token',)

    ]);
  }
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

