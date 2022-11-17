import 'package:flutter/material.dart';
import 'package:rent_collection_app/views/body_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 47, 92, 87),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 94, 43, 153),
        title: const Text("Rent Collection"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: ElevatedButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(DateTime.now().month),
                    lastDate: DateTime(2100));

                // if 'Cancel' => null
                if (newDate == null) {
                  return;
                } else {
                  setState(() {
                    date = newDate;
                  });
                }
              },
              child: Text(
                '${date.year}/${date.month}/${date.day}',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      // appBar: CalendarAppBar(
      //   onDateChanged: (value) => print(value),
      //   firstDate: DateTime.now().subtract(Duration(days: 140)),
      //   lastDate: DateTime.now(),
      // ),
      drawer: Drawer(
        child: ListView(
          children: const [
            ListTile(
              title: Text("History"),
            ),
            ListTile(
              title: Text("Save Data"),
            ),
            ListTile(
              title: Text("Exit"),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: body_content(),
      ),
    );
  }
}
