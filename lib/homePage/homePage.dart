import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lookbook/homePage/add.dart';
import '../services/database.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  final String title = "Home";

  String name;
  String brand;
  String cat;

  void test() {
    setState(() {
      empty = !empty;
    });
    new DatabaseService().addLook([this.name, this.brand, this.cat]);
  }

  bool empty = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: appBarBuilder(),
      body: body(context, empty, size),
    );
  }

  button() {
    if (empty) {
      return CupertinoButton(
        child: new Opacity(
          opacity: 0.4,
          child: new Text(
            "Sélectionner",
            style: new TextStyle(color: Colors.red),
          ),
        ),
        onPressed: null,
      );
    } else {
      return CupertinoButton(
        child: new Text("Sélectionner"),
        onPressed: () {},
      );
    }
  }

  appBarBuilder() {
    return new AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: new Text(
        title,
        style: new TextStyle(color: Colors.black),
      ),
      //centerTitle: true,
      leadingWidth: 100,
      leading: new Container(
        child: new CupertinoButton(
          child: new Text("Profil"),
          onPressed: test,
        ),
      ),
      actions: [
        new Container(
          child: button(),
        ),
      ],
    );
  }

  emptyBody() {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
            margin: EdgeInsets.only(
              bottom: 25,
            ),
            child: new Text(
              "C'est vide.",
              style: new TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          new Container(
            child: new CupertinoButton(
              child: new Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                height: 70,
                width: 70,
                child: new Icon(Icons.add),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => AddItem(),
                  ),
                );
              },
            ),
          ),
          new Opacity(
            opacity: 0.5,
            child: new Container(
              decoration: new BoxDecoration(),
              child: new Text("Ajouter item".toUpperCase()),
            ),
          ),
        ],
      ),
    );
  }

  fullBody(Size size, AsyncSnapshot<QuerySnapshot> snapshot) {
    // ignore: deprecated_member_use
    List<Widget> content = new List<Widget>();

    for (int i = 0; i < snapshot.data.docs.length; i++) {
      Widget tmp = new Container(
        margin: EdgeInsets.only(top: 25, bottom: 25),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            new Container(
              height: 250,
              width: size.width / 2.5,
              decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    blurRadius: 10,
                    color: new Color(0x16448250),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            new Container(
              height: 250,
              width: size.width / 2.5,
              decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    blurRadius: 20,
                    color: new Color(0x15790320),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ],
        ),
      );
      content.add(tmp);
    }
    return new SingleChildScrollView(
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: new Row(
                children: <Widget>[
                  new Container(
                    height: 250,
                    width: size.width / 2.5,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        new BoxShadow(
                          blurRadius: 10,
                          color: new Color(0x16448250),
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  body(BuildContext context, bool empty, Size size) {
    DatabaseService db = new DatabaseService();
    CollectionReference cr = db.getLookCollection();
    return new Container(
      child: new StreamBuilder<QuerySnapshot>(
        stream: cr.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return empty ? emptyBody() : fullBody(size, snapshot);
        },
      ),
    );
  }
}
