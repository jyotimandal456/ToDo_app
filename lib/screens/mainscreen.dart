import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Colors/custom_colors.dart';
import 'package:untitled/providers/home_provider.dart';
import 'package:untitled/screens/Activity_screen.dart';
import 'package:untitled/screens/Dashbordscreen.dart';
import 'package:untitled/screens/Introscreen.dart';
import 'package:untitled/screens/Task_screen.dart';
import 'package:untitled/screens/loginScreen.dart';
class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  final List<Widget> screens = [
    //Homescreen(),
    //Loginscreen(),
    Dashbordscreen(),
    ActivityScreen(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // return Consumer<HomeProvider>(
    //   builder: (context,provider,_){
    return Scaffold(

      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,

      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color:CustomColors.shadow(context),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          shape:  CircleBorder(),
          backgroundColor: CustomColors.primary(context),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => TaskScreen(editIndex: null,)));
          },
          child:  Icon(Icons.add_rounded,
          color: CustomColors.subtitle(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        // child: FloatingActionButton(
        //   onPressed: () {
        //     //TextEditingController controller = TextEditingController();
        //     Navigator.push(
        //         context, MaterialPageRoute(builder: (_) => TaskScreen()));
        //   },
        //   child: Icon(
        //     Icons.add_rounded,
        //     color: CustomColors.primary(context),
        //   ),
        // ),
      ),

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomAppBar(
          height: 63,
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          color: CustomColors.primary(context),
          child: SizedBox(height: 50,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    icon: Icons.home,
                    index: 0,
                  ),
                  SizedBox(width: 40),
                  _buildNavItem(
                    icon: Icons.assignment,
                    index: 1,
                  ),
                  // BottomNavigationBarItem(icon:Icon(Icons.home),label: 'Home'),
                  // BottomNavigationBarItem(icon:Icon(Icons.task),label: 'Task'),
                ]
            ),
          ),
        ),
      ),
      body: screens[currentIndex],
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
  }) {
    bool selected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: selected
            ? BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        )
            : null,
        child: Icon(
          icon,
          color: selected ? Colors.black : Colors.white,
          size: 25,
        ),
      ),
    );
  }
}

