import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject{
  UserData({
    required this.name,
    required this.age,
    required this.qualification,
    required this.address
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  String qualification;

  @HiveField(3)
  String address;
}