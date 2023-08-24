import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_application/db/model/data_model.dart';

ValueNotifier<List<Studentmodel>> studentlistNotifier = ValueNotifier([]);

void addStudent(Studentmodel value) async {
  final studentdb = await Hive.openBox<Studentmodel>('student_db');
  await studentdb.add(value);
  studentlistNotifier.value.add(value);
  studentlistNotifier.notifyListeners();
}

getAllStudents() async {
  final studentdb = await Hive.openBox<Studentmodel>('student_db');
  studentlistNotifier.value.clear();
  studentlistNotifier.value.addAll(studentdb.values);
  studentlistNotifier.notifyListeners();
}

void deletestudent(int id) async {
  final studentdb = await Hive.openBox<Studentmodel>('student_db');
  await studentdb.deleteAt(id);
  getAllStudents();
}

void editstudent(index, Studentmodel value) async {
  final studentdb = await Hive.openBox<Studentmodel>('student_db');
  studentlistNotifier.value.clear();
  studentlistNotifier.value.addAll(studentdb.values);
  studentdb.putAt(index, value);
}
