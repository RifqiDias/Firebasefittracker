import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasefittracker/model/class_model.dart';
import 'package:flutter/material.dart';

class FireProvider extends ChangeNotifier {
  final _dataDB = FirebaseFirestore.instance;
  List<User> users = [];
  FireProvider() {
    getData();
  }

  void deleteData(String id, BuildContext context) async {
    final snackBar = SnackBar(
      content: const Text('Yay! data was deleted!'),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
    await _dataDB.collection("users").doc(id).delete().then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(snackBar),
        );
    getData();
  }

  void addData(User user) async {
    await _dataDB.collection("users").add(user.toMap());
    getData();
  }

  void getData() async {
    var listData = await _dataDB.collection("users").orderBy("born").get();
    users = listData.docs.map((e) {
      User user = User.fromMap(e.data());
      user.id = e.reference.id;
      return user;
    }).toList();

    notifyListeners();
    await _dataDB.collection("users").orderBy("born").get();
  }

  void updateData() async {
    var listData = await _dataDB.collection("users").orderBy("born").get();
    users = listData.docs.map((e) {
      User user = User.fromMap(e.data());
      user.id = e.reference.id;
      return user;
    }).toList();

    notifyListeners();
    await _dataDB.collection("users").orderBy("born").get();
  }
}
