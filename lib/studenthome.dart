import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_application/StudentDetails.dart';
import 'package:student_application/db/functions/db_functions.dart';
import 'package:student_application/db/model/data_model.dart';

class StudentHOme extends StatefulWidget {
  const StudentHOme({super.key});

  @override
  State<StudentHOme> createState() => _StudentHOmeState();
}

class _StudentHOmeState extends State<StudentHOme> {
  var namecontroller = TextEditingController();
  var agecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var addresscontroller = TextEditingController();
  var coursecontroller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  File? selectedimage;

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 80, 0, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'S T U D E N T',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 100,
                              backgroundImage: selectedimage != null
                                  ? FileImage(selectedimage!)
                                  : AssetImage("assets/images/profile.png")
                                      as ImageProvider),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.black)),
                                  onPressed: () {
                                    fromgallery();
                                  },
                                  child: Text('G A L L E R Y')),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.black)),
                                  onPressed: () {
                                    fromcam();
                                  },
                                  child: Text('C A M E R A')),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field Is Empty';
                                }
                              },
                              controller: namecontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'N A M E',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field Is Empty';
                                }
                              },
                              keyboardType: TextInputType.number,
                              controller: agecontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'A G E',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field Is Empty';
                                }
                              },
                              controller: emailcontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'E M A I L',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field Is Empty';
                                }
                              },
                              controller: addresscontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'A D D R E S S',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field Is Empty';
                                }
                              },
                              controller: coursecontroller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'C O U R S E',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.black)),
                                onPressed: studentAdding,
                                child: Text('S U B M I T'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> studentAdding() async {
    if (formkey.currentState!.validate()) {
      final _name = namecontroller.text.trim();
      final _age = agecontroller.text.trim();
      final _email = emailcontroller.text.trim();
      final _address = addresscontroller.text.trim();
      final _course = coursecontroller.text.trim();
      if (_name.isEmpty ||
          _age.isEmpty ||
          _email.isEmpty ||
          _address.isEmpty ||
          _course.isEmpty) {
        return;
      } else {
        final student = Studentmodel(
            name: _name,
            age: _age,
            email: _email,
            address: _address,
            course: _course,
            image: selectedimage!.path);

        addStudent(student);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Student Added Successfully',
          ),
          behavior: SnackBarBehavior.floating,
        ));

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsScreen(),
        ));
      }
    }
  }

  fromgallery() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      selectedimage = File(returnedimage!.path);
    });
  }

  fromcam() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selectedimage = File(returnedimage!.path);
    });
  }
}
