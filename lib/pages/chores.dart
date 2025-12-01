import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chores extends StatefulWidget {
  const Chores({super.key});
  @override
  State<Chores> createState() => _ChoresState();
}

class _ChoresState extends State<Chores> {
  //Ref is what you use to interact with the database.
  final ref = FirebaseFirestore.instance.collection("Chores");

  final choreTitle = TextEditingController();
  final responsiblePerson = TextEditingController();
  DateTime? date;
  TimeOfDay? time;

  //This widget opens up a calendar where the user can pick the date.
  Future pickDate() async {
    final tempDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    //if the user picked a date, then that date gets set to the variable.
    if (tempDate != null) setState(() => date = tempDate);
  }

  Future pickTime() async {
    final tempTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (tempTime != null) {
      setState(() => time = tempTime);
    }
  }

  Future openForm() async {
    //Cleans the text

    choreTitle.clear();

    responsiblePerson.clear();
    date = null;

    showModalBottomSheet(
      //this pulls up another screen from the bottom that will be used for the form.
      isScrollControlled: true,
      context: context,

      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
        ),

        child: Column(
          mainAxisSize: MainAxisSize.max,
          //This makes sure that the bottom sheet only takes as much space as needed.
          children: [
            TextField(
              controller: choreTitle,
              decoration: const InputDecoration(labelText: "Chore"),
            ),
            TextField(
              controller: responsiblePerson,

              decoration: const InputDecoration(labelText: "Responsible"),
            ),
            TextButton(
              onPressed: pickDate,
              child: Text(date == null ? "Pick Date" : date.toString()),
            ),
            TextButton(
              onPressed: pickTime,
              child: Text(time == null ? "Pick Time" : time!.format(context)),
            ),

            ElevatedButton(
              onPressed: () async {
                if (choreTitle.text.isEmpty ||
                    responsiblePerson.text.isEmpty ||
                    date == null ||
                    time == null)
                  return;
                //This sends the data to the firebase database
                await ref.add({
                  "choreTitle": choreTitle.text,
                  "responsiblePersononsible": responsiblePerson.text,
                  "dueDate": Timestamp.fromDate(
                    DateTime(
                      date!.year,
                      date!.month,
                      date!.day,
                      time!.hour,
                      time!.minute,
                    ),
                  ),
                });
                Navigator.pop(context);
              },

              child: const Text("Save"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Listens to firebase. Will update when something changes.
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            //If no data, load spinner.
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) => ListTile(
              title: Text(docs[i]["choreTitle"]),
              subtitle: Text(docs[i]["responsiblePersononsible"]),
            ),
          );
        },
      ),

      //The button that pops the screen up
      floatingActionButton: FloatingActionButton(
        onPressed: openForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}
