import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SharedNotepad extends StatefulWidget {
  const SharedNotepad({super.key});

  @override
  State<SharedNotepad> createState() => SharedNotepadState();
}

class SharedNotepadState extends State<SharedNotepad> {
  final TextEditingController controller = TextEditingController();
  final CollectionReference notesRef = FirebaseFirestore.instance.collection(
    "SharedNotepad",
  );

  Future<void> addNote() async {
    if (controller.text.trim().isEmpty) return;

    await notesRef.add({"Content": controller.text.trim()});

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  //Handles the text input for the new notes
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Write a note...",
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send), onPressed: addNote),
              ],
            ),
          ),

          //This displays the notes.

          //Not very well though, so update fix at some point!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: notesRef.snapshots(),

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final note = docs[index]["Content"];

                    return ListTile(title: Text(note));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
