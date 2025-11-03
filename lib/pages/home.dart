import 'package:flutter/material.dart';
import 'package:househaus/pages/profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('HomePage', style: TextStyle(color: Colors.red)),
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
      ),
    );
  }
}
