import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class MediaDataService{

  static final _instance = MediaDataService();

  static MediaDataService getInstance(){
    return _instance;
  }

  BoxCollection? collection;

  Future<BoxCollection> initializeDB() async{
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    collection = await BoxCollection.open(
      'media_db', // Name of your database
      {'media'}, // Names of your boxes
      path: appDocumentsDir.path, // Path where to store your boxes (Only used in Flutter / Dart IO)
    );
    return collection!;
  }

  Future<BoxCollection> getCollection() async {
    if(collection == null){
      await initializeDB();
    }
    return collection!;
  }

  Future<CollectionBox<Map<dynamic, dynamic>>> getMediaBox() async{
    final collection = await getCollection();
    return await collection.openBox('media');
  }

  setValues(String path,String base64String) async{
    final mediaBox = await getMediaBox();
    await mediaBox.put(path, {
      'media':base64String
    });
  }

  Future<Map<dynamic, dynamic>?> getValues(String path) async{
    final mediaBox = await getMediaBox();
    return await mediaBox.get(path);
  }
}