import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_project/image_video_conversion_service.dart';
import 'package:hive_project/media_data_service.dart';
import 'dart:io';

class VideoDetails extends StatefulWidget {
  String videoPath;
  VideoDetails({super.key, required this.videoPath});

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  Map<dynamic, dynamic>? vidDetails;
  String? videoPath;

  void initState() {
    super.initState();
    getVideoDetails();
  }

  getVideoDetails() async {
    var vid = await MediaDataService.getInstance().getValues(widget.videoPath);
    var path = await ImageVideoConversionService.getInstance().base64toFileConversion(vid?['media']);
    setState(() {
      vidDetails = vid;
      videoPath = path;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back)),
        title: const Text('Video details'),
      ),
      body: Column(children: [
         Expanded(
          flex: 1,
          child: Text(vidDetails?['media'] != null ? '${vidDetails?['media']}' : '')),
      ]),
      );
  }
}