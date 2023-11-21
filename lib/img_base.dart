import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_project/data_service.dart';
import 'package:hive_project/image_video_conversion_service.dart';
import 'package:hive_project/media_data_service.dart';
import 'package:hive_project/img_details.dart';
import 'package:image_picker/image_picker.dart';

class ImageBase extends StatefulWidget {
  const ImageBase({super.key});

  @override
  State<ImageBase> createState() => _ImageBaseState();
}

class _ImageBaseState extends State<ImageBase> {
  XFile? galleryImage;
 
  onChangeImage() async {
    ImagePicker imagePicker = ImagePicker();
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      galleryImage = image;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload image/ video')),
      body: Center(
        child: Column(
          children: [
            
            TextButton(
                onPressed: onChangeImage, child: const Text('Change photo')),
            TextButton(
                onPressed: () {
                  ImageVideoConversionService.getInstance()
                      .imageVideoConversion(galleryImage!.path);
                },
                child: const Text('Save photo')),
           
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MediaDtails(imagPath: galleryImage!.path)),
                  );
                },
                child: const Text('Get image details'))
          ],
        ),
      ),
    );
  }
}
