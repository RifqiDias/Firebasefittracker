import 'package:firebasefittracker/model/profile_model.dart';
import 'package:firebasefittracker/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _heighttController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: Consumer<ProfileProvider>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
          ),
          body: value.users.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("name"),
                          Text(value.users.first.name.toString() == '' ? '' : value.users.first.name.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("height"),
                          Text(value.users.first.height.toString() == '' ? '' : value.users.first.height.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("gender"),
                          Text(value.users.first.gender.toString() == '' ? '' : value.users.first.gender.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("date of birth"),
                          Text(value.users.first.dateofbirth.toString()),
                        ],
                      ),
                      Center(
                        child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  actions: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _nameController.clear();
                                            _heighttController.clear();
                                            _genderController.clear();
                                            _dobController.clear();
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
                                            final userProfile = ProfileModel(
                                                dateofbirth: _dobController.text,
                                                gender: _genderController.text,
                                                name: _nameController.text,
                                                id: "1",
                                                height: int.parse(_heighttController.text));
                                            value.addData(userProfile);
                                            _nameController.clear();
                                            _heighttController.clear();
                                            _genderController.clear();
                                            _dobController.clear();
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
                                  content: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    const Text("name"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextField(
                                      controller: _nameController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(width: 1, color: Colors.blue),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("gender"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextField(
                                      controller: _genderController,
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(width: 1, color: Colors.blue),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("DOB"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextField(
                                      controller: _dobController,
                                      keyboardType: TextInputType.text,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(width: 1, color: Colors.blue),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("height"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextField(
                                      controller: _heighttController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(3)
                                      ],
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(width: 1, color: Colors.blue),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                              child: const Text(
                                // value.users.length == 0 ? "Edit Profile" : "Add Profile",
                                "Add/edit profile",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
