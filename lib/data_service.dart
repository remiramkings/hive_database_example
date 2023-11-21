import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DataService {
  static final DataService _instance = DataService();
  static DataService getInstance() {
    return _instance;
  }

  BoxCollection? collection;

  Future<BoxCollection> initializeDB() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    collection = await BoxCollection.open(
      'user_db', // Name of your database
      {'users'}, // Names of your boxes
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

  Future<CollectionBox<Map<dynamic, dynamic>>> getUsersBox() async {
    final collection = await getCollection();
    return await collection.openBox('users');
  }

  setValues(String name, int age, String qualification, String address, String? imagePath, String? videoPath) async {
    final usersBox = await getUsersBox();
    await usersBox.put(name, {
      'name': name,
      'age': '$age',
      'qualification': qualification,
      'address': address,
      'image':imagePath,
      'video' :videoPath
    });
  }

  Future<Map<dynamic, dynamic>?> getValues(String name) async {
    final usersBox = await getUsersBox();
    return await usersBox.get(name);
  }

  Future<List<String>> getKeys() async{
    final userBox = await getUsersBox();
    return await userBox.getAllKeys();
  }

  Future<Map<String, Map<dynamic, dynamic>>> getUserValues() async{
    final userBox = await getUsersBox();
    return await userBox.getAllValues();
  }

   deleteData(String key) async{
    final userBox = await getUsersBox();
    return await userBox.delete(key);
  }
}
