import 'package:flutter/material.dart';

class Silverscreen extends StatefulWidget {
  const Silverscreen({super.key});

  @override
  State<Silverscreen> createState() => _SilverscreenState();
}

class _SilverscreenState extends State<Silverscreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.purple.shade50,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("TabBar Example"),
          bottom:  TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.settings)),
              Tab(icon: Icon(Icons.favorite_border)),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            Container(
              color: Colors.blue,
              child: Text(
                "1st Tab",
                style: TextStyle(fontSize: 22),
              ),
            ),
           Container(
             color: Colors.green,
              child: Text(
                "2nd Tab",
                style: TextStyle(fontSize: 22),
              ),
            ),
            Container(
              color: Colors.yellow,
              child: Text(
                "3rd Tab",
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// child:CustomScrollView(
//   slivers: [
//     SliverAppBar(
//       backgroundColor: Colors.deepPurple.shade200,
//       leading:Icon(Icons.menu),
//       title:Text('silverappbar'),
//       expandedHeight: 200,
//       // floating: true,
//       pinned: true,
//       flexibleSpace: FlexibleSpaceBar(
//         background:Container(
//           color: Colors.pink.shade300,
//         ) ,
//         //  title: Text('Sliverappbar'),
//       ),
//
//     ),
//     SliverToBoxAdapter(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Container(
//               height: 400,
//               color: Colors.deepPurple,),
//           ),
//         )),
//     SliverToBoxAdapter(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Container(
//               height: 400,
//               color: Colors.deepPurple,),
//           ),
//         )),
//     SliverToBoxAdapter(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Container(
//               height: 400,
//               color: Colors.deepPurple,),
//           ),
//         )),
//     SliverToBoxAdapter(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Container(
//               height: 400,
//               color: Colors.deepPurple,),
//           ),
//         )),
//
//   ],
//
// ),
