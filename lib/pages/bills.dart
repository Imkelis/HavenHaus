import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  //Ref is what you use to interact with the database.
  final ref = FirebaseFirestore.instance.collection("Bills");

  final billTitle = TextEditingController();

  final amount = TextEditingController();
  String repeat = "Monthly";

  final repeats = ["Daily", "Weekly", "Monthly", "Yearly"];

  Future openForm() async {
    ///Cleans the text

    billTitle.clear();
    amount.clear();
    repeat = "Monthly";

    showModalBottomSheet(
      //this pulls up another screen from the bottom that will be used for the form.
      isScrollControlled: true,
      context: context,

      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,

          left: 20,
          right: 20,
          top: 20,
        ),

        child: Column(
          mainAxisSize: MainAxisSize.max,
          //This makes sure that the bottom sheet only takes as much space as needed.
          children: [
            TextField(
              controller: billTitle,

              decoration: const InputDecoration(labelText: "Bill name"),
            ),
            TextField(
              controller: amount,
              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: "Amount"),
            ),

            const SizedBox(height: 10),

            //Button with multiple strings. This is where the user selects how often the bill is reoccuring
            DropdownButton<String>(
              value: repeat,
              items: repeats.map((r) {
                return DropdownMenuItem(value: r, child: Text(r));
              }).toList(),
              onChanged: (v) => setState(() => repeat = v!),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (billTitle.text.isEmpty || amount.text.isEmpty) return;

                //This sends the data to the firebase database
                await ref.add({
                  "billTitle": billTitle.text,
                  "amount": double.tryParse(amount.text) ?? 0,
                  "repeat": repeat,
                });

                Navigator.pop(context);
              },
              child: const Text("Save Bill"),
            ),
          ],
        ),
      ),
    );
  }

  // Calcuates the monthy clost of the bill
  double calculateMonthlyCost(double amount, String repeat) {
    switch (repeat) {
      case "Daily":
        return amount * 30;
      case "Weekly":
        return amount * 4;
      case "Monthly":
        return amount;
      case "Yearly":
        return amount / 12;
      default:
        return amount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Listens to firebase. Will update when something changes.
      body: StreamBuilder(
        stream: ref.snapshots(),

        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            //If no data, load spinner.
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          double totalMonthly = 0;

          //Loops for each bill on the list, and calculates the sum. Monthly
          for (var d in docs) {
            final amount = d["amount"] * 1.0;
            final rep = d["repeat"];
            totalMonthly += calculateMonthlyCost(amount, rep);
          }

          return Column(
            children: [
              const SizedBox(height: 40),

              Text(
                "Monthly Cost: €${totalMonthly.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 22),
              ),

              const SizedBox(height: 20),

              Expanded(
                //Creates the list displaying all of the bills
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (_, i) {
                    final data = docs[i];
                    final monthly = calculateMonthlyCost(
                      data["amount"] * 1.0,
                      data["repeat"],
                    );

                    return ListTile(
                      title: Text("${data["billTitle"]} (€${data["amount"]})"),
                      subtitle: Text(
                        "Repeat: ${data["repeat"]}\nMonthly: €${monthly.toStringAsFixed(2)}",
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}
