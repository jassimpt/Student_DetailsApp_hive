import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_application/controllers/db_function_provider.dart';

import 'package:student_application/models/data_model.dart';
import 'package:student_application/views/profilescreen.dart';
import 'package:student_application/views/studenthome.dart';
import 'package:student_application/views/updatescreen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    Provider.of<DbProvider>(context, listen: false).loadStudents();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DbProvider>(context).getAllStudents();

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: Text(
                'Search for Student',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.white),
                onChanged: (value) {
                  Provider.of<DbProvider>(context, listen: false)
                      .filterStudents(value);
                },
              ),
            ),
            Expanded(
                flex: 2,
                child: Consumer<DbProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: value.foundstudent.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = value.foundstudent[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 20,
                            child: ListTile(
                              onTap: () {
                                userprofile(context, data);
                              },
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: data.image != null
                                      ? FileImage(File(data.image!))
                                      : const AssetImage(
                                              'assets/images/profile.png')
                                          as ImageProvider),
                              title: Text(data.name),
                              subtitle: Text(data.age!),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Provider.of<DbProvider>(context,
                                                listen: false)
                                            .deletestudent(index);
                                      },
                                      icon: const Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => EditScreen(
                                            index: index,
                                            name: data.name,
                                            age: data.age!,
                                            email: data.email!,
                                            address: data.address!,
                                            course: data.course!,
                                            image: data.image,
                                          ),
                                        ));
                                      },
                                      icon: const Icon(Icons.edit_document)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    child: const Icon(Icons.add),
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  userprofile(BuildContext context, Studentmodel student) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(user: student),
        ));
  }
}
