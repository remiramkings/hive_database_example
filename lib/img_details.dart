import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_project/image_video_conversion_service.dart';
import 'package:hive_project/media_data_service.dart';
import 'package:hive_project/video_details.dart';
import 'package:image_picker/image_picker.dart';

class MediaDtails extends StatefulWidget {
  String imagPath;

  MediaDtails({super.key, required this.imagPath});

  @override
  State<MediaDtails> createState() => _MediaDtailsState();
}

class _MediaDtailsState extends State<MediaDtails> {
  Map<dynamic, dynamic>? imgDetails;
  Map<dynamic, dynamic>? videoDetails;
  XFile? galleryVideo;

  void initState() {
    super.initState();
     getImgDetails();
  }

  getImgDetails() async {
    var v = await MediaDataService.getInstance().getValues(widget.imagPath);
    setState(() {
      imgDetails = v;
    });
  }

  uploadVideo() async {
    ImagePicker imagePicker = ImagePicker();
    var video = await imagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      galleryVideo = video;
    });
  }

  XFile? galleryImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back)),
        title: const Text('Image details'),
      ),
      body: Column(children: [
        Center(
          child: Container(
            height: 50,
            width: 50,
            child: imgDetails != null
                ? Image.memory(
                    base64Decode(imgDetails?['media']),
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/images/avatar.jpeg'),
          ),
        ),
        const SizedBox(height: 20),
         TextButton(
                onPressed: uploadVideo, child: const Text('Upload video')),
            TextButton(
                onPressed: () {
                  ImageVideoConversionService.getInstance()
                      .imageVideoConversion(galleryVideo!.path);
                },
                child: const Text('Save video')),
        
        TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoDetails(videoPath: galleryVideo!.path)),
                  );
                },
                child: const Text('Get video details'))
        
      ]),
    );
  }
}
