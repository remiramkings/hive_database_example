import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_project/all_user-details.dart';
import 'package:hive_project/data_service.dart';
import 'package:hive_project/user_details.dart';
import 'package:image_picker/image_picker.dart';

class UserForm extends StatefulWidget {
  String? name;
  int? age;
  String? qualification;
  String? address;
  bool isEdit;
  UserForm(
      {super.key,
      this.name,
      this.age,
      this.qualification,
      this.address,
      this.isEdit = false});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  XFile? galleryImage;
  XFile? galleryVideo;

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.text = widget.isEdit ? name.text = widget.name! : name.text = '';
    age.text = widget.isEdit ? age.text = '${widget.age!}' : age.text = '';
    qualification.text = widget.isEdit
        ? qualification.text = widget.qualification!
        : qualification.text = '';
    address.text =
        widget.isEdit ? address.text = widget.address! : address.text = '';
  }

  onChangeImage() async {
    ImagePicker imagePicker = ImagePicker();
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      galleryImage = image;
    });
  }

  uploadVideo() async {
    ImagePicker imagePicker = ImagePicker();
    var video = await imagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      galleryVideo = video;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AllUserDetails(),
              ),
            );
          },
        ),
        title: widget.isEdit
            ? const Text('Edit your details')
            : const Text('User Form'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 50,
                width: 50,
                child: galleryImage != null
                    ? Image.file(File(galleryImage!.path))
                    : Image.asset('assets/images/avatar.jpeg'),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: onChangeImage, child: const Text('Change photo')),
              TextFormField(
                  controller: name,
                  decoration: const InputDecoration(hintText: 'Name')),
              TextFormField(
                  controller: age,
                  decoration: const InputDecoration(hintText: 'Age')),
              TextFormField(
                  controller: qualification,
                  decoration: const InputDecoration(hintText: 'Qualification')),
              TextFormField(
                  controller: address,
                  decoration: const InputDecoration(hintText: 'Address')),
              const SizedBox(height: 30),
              TextButton(onPressed: uploadVideo, child: const Text('Upload video')),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () async {
                    await DataService.getInstance().setValues(
                        name.text,
                        int.parse(age.text),
                        qualification.text,
                        address.text,
                        galleryImage?.path,
                        galleryVideo?.path);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserDetails(name: name.text),
                      ),
                    );
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
