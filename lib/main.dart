import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minder/assets/svgs.dart';
import 'package:minder/models/page.dart';
import 'package:minder/models/reminder.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final textTheme = TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.grey),
    subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.grey[600]),
    bodyText2: TextStyle(fontSize: 14.0),
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minder',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          primarySwatch: Colors.lime,
          accentColor: Colors.lime,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          textTheme: textTheme,
          appBarTheme: AppBarTheme(backgroundColor: Colors.black)),
      theme: ThemeData(
        primarySwatch: Colors.lime,
        brightness: Brightness.light,
        textTheme: textTheme,
      ),
      home: MyHomePage(title: 'Minder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

AppPage currentPage = AppPage('Today');
int selectedIn = 0;

class _MyHomePageState extends State<MyHomePage> {
  var ctrl = TextEditingController();
  List<Reminder> reminders = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentPage.title,
          style: GoogleFonts.palanquin(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.lens_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: (reminders.length > 0)
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: reminders.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Checkbox(
                            value: reminders[index].isDone,
                            onChanged: (value) => setState(() => reminders[index].isDone = value),
                          ),
                          Text(reminders[index].text!),
                          Text(reminders[index].time.toString()),
                        ],
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.string(nightLamp),
                        SizedBox(height: 35),
                        Text(
                          'Make something happen from planing the day ahead.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Enjoy your evening.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
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
          BottomNavigationBar(
            currentIndex: selectedIn,
            onTap: (value) => setState(() {
              selectedIn = value;
            }),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.check_box), label: 'agagag'),
              BottomNavigationBarItem(
                  icon: Container(
                    width: 23,
                    height: 23,
                    child: Stack(
                      children: [
                        Center(
                          child: SvgPicture.string(
                            calendarIcon,
                            color: Colors.grey,
                          ),
                        ),
                        Center(
                          child: Text(
                            '11',
                            style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).backgroundColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  label: 'agagag'),
              BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'agagag'),
            ],
          ),
        ],
      ),
    );
  }
}
