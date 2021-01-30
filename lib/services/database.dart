import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference lookCollection =
      // ignore: deprecated_member_use
      Firestore.instance.collection('looks');

  Future addLook(List<String> infos) async {
    this
        .lookCollection
        .add({
          "name": infos[0],
          "brand": infos[1],
          "cat": infos[2],
        })
        .then(
          (value) => {
            print("Look bien ajouté"),
          },
        )
        .catchError((error) => print("pas marché"));
  }

  CollectionReference getLookCollection() {
    return this.lookCollection;
  }

  Future getData(String dbName) async {
    return this.lookCollection.get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach(
              (elem) {
                print(elem["id"]);
                print(elem.id);
              },
            ),
          },
        );
  }
}
