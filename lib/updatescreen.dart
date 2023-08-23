import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_application/StudentDetails.dart';
import 'package:student_application/db/functions/db_functions.dart';
import 'package:student_application/db/model/data_model.dart';

class EditScreen extends StatefulWidget {
  const EditScreen(
      {super.key,
      required this.name,
      required this.age,
      required this.email,
      required this.address,
      required this.course,
      required this.image,
      required this.index});
  final String name;
  final String age;
  final String email;
  final String address;
  final String course;
  final dynamic image;
  final int index;

  @override
  State<EditScreen> createState() => _EditScreen();
}

class _EditScreen extends State<EditScreen> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController agecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  final TextEditingController coursecontroller = TextEditingController();

  File? selectedimage;

  @override
  void initState() {
    namecontroller.text = widget.name;
    agecontroller.text = widget.age;
    emailcontroller.text = widget.email;
    addresscontroller.text = widget.address;
    coursecontroller.text = widget.course;
    selectedimage = widget.image != null ? File(widget.image) : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
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
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.black)),
                                onPressed: () {
                                  fromgallery();
                                },
                                child: Text('G A L L E R Y')),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.black)),
                                onPressed: () {
                                  fromcam();
                                },
                                child: Text('C A M E R A')),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
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
                              onPressed: () {
                                update();
                              },
                              child: Text('U P D A T E'),
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
    );
  }

  update() async {
    final edited_name = namecontroller.text.trim();
    final edited_age = agecontroller.text.trim();
    final edited_email = emailcontroller.text.trim();
    final edited_address = addresscontroller.text.trim();
    final edited_course = coursecontroller.text.trim();
    final edited_image = selectedimage?.path;

    if (edited_name.isEmpty ||
        edited_age.isEmpty ||
        edited_email.isEmpty ||
        edited_address.isEmpty ||
        edited_course.isEmpty) {
      return;
    }
    final updated = Studentmodel(
        name: edited_name,
        age: edited_age,
        email: edited_email,
        address: edited_address,
        course: edited_course,
        image: edited_image);

    editstudent(widget.index, updated);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Updated Successfully'),
      behavior: SnackBarBehavior.floating,
    ));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DetailsScreen(),
    ));
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
