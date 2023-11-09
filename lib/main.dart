import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_application/controllers/db_function_provider.dart';
import 'package:student_application/controllers/imagepicker_provider.dart';
import 'package:student_application/models/data_model.dart';

import 'package:student_application/views/StudentDetails.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DbProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImagePickerProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        debugShowCheckedModeBanner: false,
        title: 'student app',
        home: DetailsScreen(),
      ),
    );
  }
}
