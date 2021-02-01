import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minder/models/reminder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minder',
      theme: ThemeData(
        primarySwatch: Colors.lime,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Minder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var ctrl = TextEditingController();
  List<Reminder> reminders = [Reminder(text: 'Do something', time: DateTime.now().add(Duration(days: 1)))];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.palanquin(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Checkbox(
                        value: reminders[index].isDone,
                        onChanged: (value) => setState(() => reminders[index].isDone = value),
                      ),
                      Text(reminders[index].text),
                      Text(reminders[index].time.toString()),
                    ],
                  );
                },
              ),
            ),
            TextField(
              controller: ctrl,
              onEditingComplete: () {
                setState(() {
                  reminders.add(Reminder(text: ctrl.text));
                  ctrl.clear();
                });
              },
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: ()=>{},
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),*/
    );
  }
}
