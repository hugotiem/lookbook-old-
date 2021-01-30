import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lookbook/homePage/testPage.dart';

//NAV PAGES
import 'homePage/homePage.dart';
import 'homePage/add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Home();
  }
}

class _Home extends State<Home> {
  int currentTabIndex = 0;

  displayPage() {
    switch (currentTabIndex) {
      case 0:
        return new HomePage();
        break;
      case 2:
        return new ListViewTest();
        break;
      default:
        return new HomePage();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new CupertinoTabBar(
        currentIndex: currentTabIndex,
        backgroundColor: Colors.white,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
          ),
          new BottomNavigationBarItem(
            icon: Container(
              child: new CupertinoButton(
                padding: EdgeInsets.only(bottom: 0),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => AddItem(),
                    ),
                  );
                },
                child: new Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
          ),
        ],
        onTap: (int index) {
          if (index != 1) {
            setState(() {
              currentTabIndex = index;
            });
          }
        },
      ),
      body: displayPage(),
    );
  }
}
