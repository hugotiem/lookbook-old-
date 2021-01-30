import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lookbook/services/database.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  int currentTabIndex = 0;
  List<int> currentSelectedIndex = new List.filled(10, 0);

  PickedFile _image;

  String brand;
  String cat;

  bool isBrandEmpty = true;
  bool isCatEmpty = true;

  Future _getImage() async {
    var imagePicker = new ImagePicker();

    var image = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _image = image;
      print("image : ${_image.readAsString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => {
        FocusScope.of(context).requestFocus(FocusNode()),
      },
      child: new Scaffold(
        appBar: appBarBuilder(context),
        bottomNavigationBar: new Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: new CupertinoTabBar(
            currentIndex: this.currentTabIndex,
            items: [
              new BottomNavigationBarItem(
                icon: new Text(
                  "Look",
                  style: new TextStyle(fontSize: 20),
                ),
              ),
              new BottomNavigationBarItem(
                icon: new Text(
                  "Item",
                  style: new TextStyle(fontSize: 20),
                ),
              )
            ],
            onTap: (int index) {
              setState(() {
                currentTabIndex = index;
              });
            },
          ),
        ),
        body: body(),
      ),
    );
  }

  appBarBuilder(BuildContext context) {
    return new AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: new Text(
        "Nouveau",
        style: new TextStyle(color: Colors.black),
      ),
      //centerTitle: true,
      leadingWidth: 100,
      leading: new Container(
        color: Colors.white,
        child: CupertinoButton(
          child: new Text("Annuler"),
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.of(context).pop();
          },
        ),
      ),
      actions: [
        new Container(
          child: new Container(
            child: new CupertinoButton(
              child: new Text("Ajouter"),
              onPressed: currentTabIndex == 0
                  ? (this.currentSelectedIndex.contains(1) ? () {} : null)
                  : ((!isBrandEmpty && !isCatEmpty) ? () {} : null),
            ),
          ),
        ),
      ],
    );
  }

  lookBody() {
    DatabaseService db = new DatabaseService();
    CollectionReference cr = db.getLookCollection();
    return new StreamBuilder(
        stream: cr.snapshots(includeMetadataChanges: true),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return new Container(
            child: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new Container(
                    decoration: new BoxDecoration(
                      border: new Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.2,
                        ),
                      ),
                    ),
                    height: 210,
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          height: 30,
                          margin: EdgeInsets.all(10),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("T-shirt"),
                              new CupertinoButton(
                                padding: EdgeInsets.all(0),
                                child: new Text("Select all"),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        new Container(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return new GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (currentSelectedIndex[index] == 0)
                                      currentSelectedIndex[index] = 1;
                                    else
                                      currentSelectedIndex[index] = 0;
                                  });
                                },
                                child: new Container(
                                  width: 100,
                                  margin: EdgeInsets.all(5),
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    border: new Border.all(
                                      color: currentSelectedIndex[index] == 0
                                          ? Colors.white
                                          : Colors.red,
                                      width: 0.5,
                                    ),
                                    borderRadius: new BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: new Text(""),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                      border: new Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.2,
                        ),
                      ),
                    ),
                    height: 210,
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          height: 30,
                          margin: EdgeInsets.all(10),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("T-shirt"),
                              new CupertinoButton(
                                padding: EdgeInsets.all(0),
                                child: new Text("Select all"),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        new Container(
                          child: new SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: new Row(
                              children: <Widget>[new Container()],
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
        });
  }

  itemBody() {
    Widget selectImage = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Container(
          child: new CupertinoButton(
            onPressed: () {},
            child: new Container(
              height: 50,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.red,
                ),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new Icon(Icons.photo_camera_outlined),
                    margin: EdgeInsets.only(right: 10),
                  ),
                  new Text("Prendre une photo"),
                ],
              ),
            ),
          ),
        ),
        new Container(
          child: new CupertinoButton(
            onPressed: () {
              _getImage();
            },
            child: new Container(
              height: 50,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.red,
                ),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new Icon(Icons.photo_library_outlined),
                    margin: EdgeInsets.only(right: 10),
                  ),
                  new Text("Ouvrir la galerie"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
    Widget imageSlected = new Column(
      children: [
        _image != null ? new Image.file(File(_image.path)) : new Container(),
        new Container(
          child: new Column(
            children: <Widget>[
              new Container(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Marque :",
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(bottom: 50),
                child: new CupertinoTextField.borderless(
                  placeholder: "ex : Prada",
                  textInputAction: TextInputAction.send,
                  onChanged: (value) => {
                    this.brand = value,
                    setState(() {
                      isBrandEmpty = !this.brand.isNotEmpty;
                    }),
                  },
                  decoration: new BoxDecoration(),
                ),
              ),
            ],
          ),
        ),
        new Container(
          child: new Column(
            children: <Widget>[
              new Container(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "Catégorie :",
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(bottom: 50),
                child: new CupertinoTextField.borderless(
                  placeholder: "ex : T-Shirt",
                  textInputAction: TextInputAction.send,
                  onChanged: (value) => {
                    this.cat = value,
                    setState(() {
                      isCatEmpty = !this.cat.isNotEmpty;
                    }),
                  },
                  decoration: new BoxDecoration(),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return new Container(
      margin: EdgeInsets.all(10),
      child: new Center(
        child: _image != null
            ? new SingleChildScrollView(
                child: imageSlected,
              )
            : selectImage,
      ),
    );
  }

  body() {
    return this.currentTabIndex == 0 ? lookBody() : itemBody();
  }
}
