import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:hive_project/data_service.dart';
import 'package:hive_project/media_data_service.dart';
import 'package:image_picker/image_picker.dart';

class ImageVideoConversionService{

  static final _instance = ImageVideoConversionService();

  static ImageVideoConversionService getInstance(){
    return _instance;
  }

  imageVideoConversion(String path) async{
    File mediaFile = File(path);
    Uint8List mediaBytes = await mediaFile.readAsBytes();
    String base64String = base64.encode(mediaBytes);
    MediaDataService.getInstance().setValues(path, base64String);
  }

  Future<String> base64toFileConversion(String base64) async{
    Uint8List decodedbytes =base64Decode(base64);
    File decodedimgfile = await File("video.mp3").writeAsBytes(decodedbytes);
    return decodedimgfile.path;
  }
}