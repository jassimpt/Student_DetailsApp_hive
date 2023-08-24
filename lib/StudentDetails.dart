import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_application/db/functions/db_functions.dart';
import 'package:student_application/db/model/data_model.dart';
import 'package:student_application/profilescreen.dart';
import 'package:student_application/studenthome.dart';
import 'package:student_application/updatescreen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String search = '';
  List<Studentmodel> searchedlist = [];

  loadstudents() async {
    final allstudents = await getAllStudents();
    setState(() {
      searchedlist = allstudents;
    });
  }

  @override
  void initState() {
    super.initState();
    loadstudents();
    searchlistupdate();
  }

  void searchlistupdate() {
    setState(() {
      searchedlist = studentlistNotifier.value
          .where((Studentmodel) =>
              Studentmodel.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Colors.black,
        //   title: Center(child: Text('S T U D E N T')),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 25),
              child: Text(
                'Search for Student',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.white),
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                  searchlistupdate();
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: ValueListenableBuilder(
                valueListenable: studentlistNotifier,
                builder: (BuildContext ctx, List<Studentmodel> studentlist,
                    Widget? child) {
                  return ListView.builder(
                    itemCount: searchedlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = searchedlist[index];
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
                                    : AssetImage('assets/images/profile.png')
                                        as ImageProvider),
                            title: Text(data.name),
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
                    child: Icon(Icons.add),
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
