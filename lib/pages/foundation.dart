import 'package:flutter/material.dart';
import 'package:househaus/pages/profile.dart';
import 'package:househaus/pages/mainManagement.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myIndex = 0;

  //List of pages my app uses / will use.
  final List<Widget> pageList = [
    MainManagement(),
    Center(child: Text("Mid Section for something")),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(context),
      //Paints the children pages onto the screen
      body: IndexedStack(index: myIndex, children: pageList),

      //This sets the navigation bar at the bottom of the screen
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 30, 184, 255),

        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.horizontal_rule),
            label: "Mid Section",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Social"),
        ],
      ),
    );
  }

  //This sets the top bar of the screen
  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 30, 184, 255),
      title: Text(
        'HavenHaus',
        style: TextStyle(color: Colors.black),
        textScaler: TextScaler.linear(1.15),
      ),
      centerTitle: true,

      leading: IconButton(
        onPressed: () {
          setState(() {
            myIndex = 2;
          });
        },
        icon: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 97, 239, 255),
            border: Border.all(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
