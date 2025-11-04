import 'package:flutter/material.dart';
import 'package:househaus/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 40),
            // height: screenHeight * .15,
            // color: Colors.blue,
            child: Text('what'),
          ),
        ],
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: "Phone"),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Alarm"),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 30, 184, 255),
      title: Text(
        'HomePage',
        style: TextStyle(color: Colors.black),
        textScaler: TextScaler.linear(1.25),
      ),
      centerTitle: true,

      //There is definetly a better way of doing this. My current aim is to figure out how to make this better.
      leading: IconButton(
        onPressed: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const Profile())),
        icon: Container(decoration: BoxDecoration(color: Colors.green)),
      ),
      actions: [
        GestureDetector(
          onTap: () => Profile(),
          child: Container(
            decoration: BoxDecoration(color: Colors.black),
            width: 50,
            alignment: Alignment.center,
          ),
        ),
      ],
    );
  }
}
