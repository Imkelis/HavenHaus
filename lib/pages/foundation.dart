import 'package:flutter/material.dart';
import 'package:househaus/pages/bills.dart';
import 'package:househaus/pages/chores.dart';
import 'package:househaus/pages/profile.dart';
import 'package:househaus/pages/mainManagement.dart';
import 'package:househaus/pages/sharedNotepad.dart';

class Foundation extends StatefulWidget {
  const Foundation({super.key});

  @override
  State<Foundation> createState() => _FoundationState();
}

class _FoundationState extends State<Foundation> {
  int myIndex = 0;

  //Function to set the index of a page.
  void onSelectPage(int index) {
    setState(() {
      myIndex = index;
    });
  }

  //This lists all of the potential pages. Used when receiving a reference from mainManagement.
  //Not sure if i like this, but it works fine so Ill keep it for now.
  @override
  Widget build(BuildContext context) {
    final List<Widget> pageList = [
      MainManagement(onSelectPage: onSelectPage),
      const Center(child: Text("Mid Section for something")),
      const Profile(),
      const SharedNotepad(),
      const Chores(),
      const BillsPage(),
    ];

    //Lists the bottom nav bar pages.
    final List<int> navToPage = [0, 1, 2];

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
            myIndex = navToPage[index];
          });
        },

        //Checks which page user is on. If the page is part of the nav bar, go there. If not, go home page.
        //Will become useless once I remove the nav bar pages from the mainManagement icon list
        currentIndex: navToPage.contains(myIndex)
            ? navToPage.indexOf(myIndex)
            : 0,

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
