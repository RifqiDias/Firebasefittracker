import 'package:firebasefittracker/model/class_model.dart';
import 'package:firebasefittracker/provider/fire_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

class AddToFirestore extends StatefulWidget {
  const AddToFirestore({Key? key}) : super(key: key);

  @override
  State<AddToFirestore> createState() => AddTotFirestoreState();
}

class AddTotFirestoreState extends State<AddToFirestore> {
  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _weightController.dispose();
  }

  DateTime dnNow = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FireProvider(),
      child: Consumer<FireProvider>(
          builder: (context, value, child) => value.users.isNotEmpty
              ? Scaffold(
                  appBar: AppBar(title: const Text("Tracking Fit")),
                  body: SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width,
                          color: Colors.pink[50],
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          child: const Text(
                            "Note : press hold to delete data",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Flexible(
                          child: ListView.separated(
                            padding: const EdgeInsets.only(bottom: 60),
                            separatorBuilder: (context, index) => const Divider(color: Colors.grey, height: 2),
                            itemCount: value.users.length,
                            itemBuilder: ((context, index) => ListTile(
                                  onLongPress: () {
                                    value.deleteData(value.users[index].id.toString(), context);
                                  },
                                  title: Text(
                                    "weight : ${value.users[index].weight.toString()}",
                                  ),
                                  trailing: Text("date : ${value.users[index].born}"),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              actions: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _weightController.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          color: Colors.red,
                                          child: const Text(
                                            "Back",
                                            style: TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        final user = User(weight: int.parse(_weightController.text), born: dnNow.day);
                                        value.addData(user);
                                        _weightController.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        color: Colors.blue,
                                        child: const Text(
                                          "Add",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                              title: const Text('Please insert weight '),
                              content: TextField(
                                controller: _weightController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(3),
                                ],
                              ),
                            )),
                    child: const Icon(Icons.add),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
