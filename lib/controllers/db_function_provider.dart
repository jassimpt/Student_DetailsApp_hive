import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:student_application/models/data_model.dart';

class DbProvider extends ChangeNotifier {
  List<Studentmodel> studentlist = [];
  List<Studentmodel> foundstudent = [];
  List<Studentmodel> result = [];

  addStudent(Studentmodel value) async {
    final studentdb = await Hive.openBox<Studentmodel>('student_db');
    await studentdb.add(value);
    studentlist.add(value);
    notifyListeners();
  }

  getAllStudents() async {
    final studentdb = await Hive.openBox<Studentmodel>('student_db');
    studentlist.clear();
    studentlist.addAll(studentdb.values);
    notifyListeners();
  }

  void deletestudent(int id) async {
    final studentdb = await Hive.openBox<Studentmodel>('student_db');
    await studentdb.deleteAt(id);
    getAllStudents();
    notifyListeners();
  }

  void editstudent(index, Studentmodel value) async {
    final studentdb = await Hive.openBox<Studentmodel>('student_db');
    studentlist.clear();
    studentlist.addAll(studentdb.values);
    studentdb.putAt(index, value);
    notifyListeners();
  }

  loadStudents() {
    final allstudents = studentlist;
    foundstudent = allstudents;
  }

  filterStudents(String searchterm) {
    if (searchterm.isEmpty) {
      result = studentlist;
    } else {
      result = studentlist
          .where((Studentmodel student) =>
              student.name.toLowerCase().contains(searchterm.toLowerCase()))
          .toList();
    }
    foundstudent = result;
    notifyListeners();
  }
}
