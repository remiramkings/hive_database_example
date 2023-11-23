import 'package:flutter/material.dart';
import 'package:hive_project/custom_audio_player.dart';

class AudioplayerUI extends StatefulWidget {
  Map<dynamic, dynamic> userDetails;
  AudioplayerUI({super.key, required this.userDetails});

  @override
  State<AudioplayerUI> createState() => _AudioplayerUIState();
}

class _AudioplayerUIState extends State<AudioplayerUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: InkWell(onTap: (){
        Navigator.pop(context);
      }, child: const Icon(Icons.arrow_back)),
      title: const Text('Audio')),
      body: Center(child: Container(child: CustomAudioPlayer(filePath: widget.userDetails['audio'] ?? "",))),
    );
  }
}