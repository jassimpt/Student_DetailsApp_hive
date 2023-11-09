import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:student_application/controllers/db_function_provider.dart';
import 'package:student_application/controllers/imagepicker_provider.dart';

import 'package:student_application/models/data_model.dart';
import 'package:student_application/views/StudentDetails.dart';

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

  @override
  Widget build(BuildContext context) {
    Provider.of<DbProvider>(context).getAllStudents();

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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 80, 0, 30),
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
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 100,
                              backgroundImage: Provider.of<ImagePickerProvider>(
                                              context,
                                              listen: false)
                                          .selectedimage !=
                                      null
                                  ? FileImage(Provider.of<ImagePickerProvider>(
                                          context,
                                          listen: false)
                                      .selectedimage!)
                                  : const AssetImage(
                                          "assets/images/profile.png")
                                      as ImageProvider),
                          Wrap(
                            spacing: 30,
                            children: [
                              ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.black)),
                                  onPressed: () {
                                    Provider.of<ImagePickerProvider>(context,
                                            listen: false)
                                        .pickimage(source: ImageSource.gallery);
                                  },
                                  child: const Text('G A L L E R Y')),
                              ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.black)),
                                  onPressed: () {
                                    Provider.of<ImagePickerProvider>(context,
                                            listen: false)
                                        .pickimage(source: ImageSource.camera);
                                  },
                                  child: const Text('C A M E R A')),
                            ],
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-z||A-Z]'))
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Field Is Empty';
                                  }
                                  return null;
                                },
                                controller: namecontroller,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'N A M E',
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Field Is Empty';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                controller: agecontroller,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'A G E',
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-z||A-Z]'))
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Field Is Empty';
                                  }
                                  return null;
                                },
                                controller: emailcontroller,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'E M A I L',
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-z||A-Z]'))
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Field Is Empty';
                                  }
                                  return null;
                                },
                                controller: addresscontroller,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'A D D R E S S',
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-z||A-Z]'))
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Field Is Empty';
                                  }
                                  return null;
                                },
                                controller: coursecontroller,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'C O U R S E',
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.black)),
                                onPressed: studentAdding,
                                child: const Text('S U B M I T'),
                              ),
                            ],
                          ),
                        ],
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
      final name = namecontroller.text.trim();
      final age = agecontroller.text.trim();
      final email = emailcontroller.text.trim();
      final address = addresscontroller.text.trim();
      final course = coursecontroller.text.trim();
      if (name.isEmpty ||
          age.isEmpty ||
          email.isEmpty ||
          address.isEmpty ||
          course.isEmpty) {
        return;
      } else {
        final student = Studentmodel(
            name: name,
            age: age,
            email: email,
            address: address,
            course: course,
            image: Provider.of<ImagePickerProvider>(context, listen: false)
                .selectedimage!
                .path);

        Provider.of<DbProvider>(context, listen: false).addStudent(student);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Student Added Successfully',
          ),
          behavior: SnackBarBehavior.floating,
        ));

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const DetailsScreen(),
        ));
      }
    }
  }
}
