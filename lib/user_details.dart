import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_project/data_service.dart';
import 'package:hive_project/user_form.dart';

class UserDetails extends StatefulWidget {
  String name;
  UserDetails({super.key, required this.name});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  Map<dynamic, dynamic>? userDetails;

  @override
  void initState(){
    super.initState();
    getUserDetails();

  }

  getUserDetails() async {
    var v = await DataService.getInstance().getValues(widget.name);
    setState(() {
      userDetails = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: InkWell(onTap: () {
        Navigator.pop(context);
      }, child: const Icon(Icons.arrow_back)),title: const Text('User details')),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
        child: Column(
          children: [
            Container(
                  height: 100,
                  width: 100,
                  child: userDetails?['image'] != null
                      ? Image.file(File(userDetails?['image']))
                      : Image.asset('assets/images/avatar.jpeg'),
                ),
            const SizedBox(height: 20),
            Text('Name : ${userDetails?['name']}'),
            Text('Age : ${userDetails?['age']}'),
            Text('Qualification : ${userDetails?['qualification']}'),
            Text('Address : ${userDetails?['address']}'),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(
                builder: (context) => UserForm(name: userDetails?['name'], age: int.parse(userDetails?['age']),
                qualification: userDetails?['qualification'], address: userDetails?['address'],
                isEdit: true,
              )),
  );
            }, child: const Text('Edit'))
          ],
        ),
      ),
    );
  }
}