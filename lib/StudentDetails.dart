import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_application/db/functions/db_functions.dart';
import 'package:student_application/db/model/data_model.dart';
import 'package:student_application/studenthome.dart';
import 'package:student_application/updatescreen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Center(child: Text('S T U D E N T')),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: ValueListenableBuilder(
                valueListenable: studentlistNotifier,
                builder: (BuildContext ctx, List<Studentmodel> studentlist,
                    Widget? child) {
                  return ListView.builder(
                    itemCount: studentlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = studentlist[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 20,
                          child: ListTile(
                            leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: data.image != null
                                    ? FileImage(File(data.image!))
                                    : AssetImage('assets/images/profile.png')
                                        as ImageProvider),
                            title: Text(data.name!),
                            subtitle: Text(data.age!),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      deletestudent(index);
                                    },
                                    icon: Icon(Icons.delete)),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => EditScreen(
                                          index: index,
                                          name: data.name!,
                                          age: data.age!,
                                          email: data.email!,
                                          address: data.address!,
                                          course: data.course!,
                                          image: data.image,
                                        ),
                                      ));
                                    },
                                    icon: Icon(Icons.edit_document)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentHOme(),
                          ));
                    },
                    child: Icon(Icons.add),
                    backgroundColor: Colors.black,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
