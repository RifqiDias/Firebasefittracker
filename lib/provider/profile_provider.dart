import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasefittracker/model/class_model.dart';
import 'package:firebasefittracker/model/profile_model.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final _dataDB = FirebaseFirestore.instance;
  List<ProfileModel> users = [];
  ProfileProvider() {
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
    await _dataDB.collection("profile").doc(id).delete().then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(snackBar),
        );
    getData();
  }

  void addData(ProfileModel user) async {
    await _dataDB.collection("profile").add(user.toMap());
    getData();
  }

  void getData() async {
    var listData = await _dataDB.collection("profile").get();
    users = listData.docs.map((e) {
      ProfileModel user = ProfileModel.fromMap(e.data());
      user.id = e.reference.id;
      return user;
    }).toList();

    notifyListeners();
    await _dataDB.collection("profile").get();
  }

  void updateData(ProfileModel model) async {
    await _dataDB.collection("profile").doc().update(model.toMap());

    // users = listData.docs.map((e) {
    //   ProfileModel user = ProfileModel.fromMap(e.data());
    //   user.id = e.reference.id;
    //   return user;
    // }).toList();

    notifyListeners();
  }
}
