import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_application/StudentDetails.dart';
import 'package:student_application/db/model/data_model.dart';
import 'package:student_application/profilescreen.dart';
import 'package:student_application/studenthome.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentmodelAdapter().typeId)) {
    Hive.registerAdapter(StudentmodelAdapter());
  }
  runApp(studentapp());
}

class studentapp extends StatelessWidget {
  const studentapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      debugShowCheckedModeBanner: false,
      title: 'student app',
      home: DetailsScreen(),
    );
  }
}
