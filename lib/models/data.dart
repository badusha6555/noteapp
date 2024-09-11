import 'package:hive/hive.dart';
part 'data.g.dart';

@HiveType(typeId: 0)
class Data {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;

  Data({required this.title, required this.description});
}
