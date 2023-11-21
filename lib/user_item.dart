import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_project/data_service.dart';
import 'package:hive_project/user_details.dart';
import 'package:hive_project/user_form.dart';

class UserItem extends StatefulWidget {
  Map<dynamic, dynamic> userDetails;
  Function onClick;
  UserItem({super.key,
    required this.userDetails,
    required this.onClick
  });

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        color: const Color.fromARGB(255, 255, 206, 206),
      ),
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: Container(
                      height: 50,
                      width: 50,
                      child: widget.userDetails['image'] != null
                          ? Image.file(File(widget.userDetails['image']))
                          : Image.asset('assets/images/avatar.jpeg'),
                    )),
                    const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Text('${widget.userDetails['name']}')),
            Expanded(
              child: Text('${widget.userDetails['age']}')),
            Expanded(
              child: Text('${widget.userDetails['qualification']}')),
            Expanded(
              flex: 2,
              child: Text('${widget.userDetails['address']}')),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                 Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>  UserForm(
                        name: widget.userDetails['name'],
                        age: int.parse(widget.userDetails['age']),
                        qualification: widget.userDetails['qualification'],
                        address: widget.userDetails['address'],
                        isEdit: true,
                      ) ,
                    ),
                  );
                },
                child: const Icon(Icons.edit, color: Colors.grey)),
            ), 
            Expanded(
              flex:1,
              child: InkWell(
                onTap: () async{
                  await DataService.getInstance().deleteData(widget.userDetails['name']);
                  widget.onClick();
                },
                child: const Icon(Icons.close, color: Colors.red)),
            )

          ],),
          Row(children: [
            Expanded(child: widget.userDetails['video'] != null? Text('Video path ${widget.userDetails['video']}') : const Text(''))
          ],)

        ],
      )
    );
  }
}