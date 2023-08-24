import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class Studentmodel {
  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? age;

  @HiveField(3)
  final String? email;

  @HiveField(4)
  final String? address;

  @HiveField(5)
  final String? course;

  @HiveField(6)
  final String? image;

  Studentmodel(
      {required this.name,
      required this.age,
      required this.email,
      required this.address,
      required this.course,
      required this.image});
}
