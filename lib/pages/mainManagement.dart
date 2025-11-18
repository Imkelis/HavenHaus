import 'package:flutter/material.dart';

class MainManagement extends StatelessWidget {
  final void Function(int) onSelectPage;
  const MainManagement({super.key, required this.onSelectPage});

  @override
  Widget build(BuildContext context) {
    final List<int> pagesIndex = [
      //This is where new icons / buttons are created. Using numbers so I can pass back the indexes back to the foundation.
      3, //SharedNotepad
      2, //Profile
      1, //Mid section
      2, //Profile
    ];
    // Creates the scrollable grid. Very cool
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: pagesIndex.length,
      itemBuilder: (context, index) {
        //Still unsure if I like this navigation, might update, but its fine for now.
        return InkWell(
          //Trying out inkwell.
          //Dont really see whats different about it vs a regular button. Ill mess with it some more later.
          onTap: () {
            onSelectPage(pagesIndex[index]);
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
