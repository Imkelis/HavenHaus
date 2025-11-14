import 'package:flutter/material.dart';
import 'package:househaus/pages/sharedNotepad.dart';
import 'profile.dart';

class MainManagement extends StatelessWidget {
  const MainManagement({super.key});

  @override
  Widget build(BuildContext context) {
    //For every page here, a new box will be displayed on the page.

    final List<Widget> pages = [
      //Remove later. For testing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      const SharedNotepad(),
      const Profile(),
      const Profile(),
      const Profile(),
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),

      itemCount: pages.length,
      itemBuilder: (context, index) {
        //Using a different way to open the pages here. May be useful.
        //Not sure if I will keep it this way, Ill decide later.
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => pages[index]),
            );
          },

          child: Container(
            color: const Color.fromARGB(255, 207, 235, 255),
            child: const Center(child: Icon(Icons.book, size: 50)),
          ),
        );
      },
    );
  }
}
