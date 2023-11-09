import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_application/controllers/db_function_provider.dart';
import 'package:student_application/controllers/imagepicker_provider.dart';
import 'package:student_application/models/data_model.dart';
import 'package:student_application/views/StudentDetails.dart';

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

  @override
  void initState() {
    namecontroller.text = widget.name;
    agecontroller.text = widget.age;
    emailcontroller.text = widget.email;
    addresscontroller.text = widget.address;
    coursecontroller.text = widget.course;
    Provider.of<ImagePickerProvider>(context, listen: false).selectedimage =
        widget.image != null ? File(widget.image) : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DbProvider>(context).getAllStudents();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
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
                                            context)
                                        .selectedimage !=
                                    null
                                ? FileImage(
                                    Provider.of<ImagePickerProvider>(context)
                                        .selectedimage!)
                                : const AssetImage("assets/images/profile.png")
                                    as ImageProvider),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.black)),
                                onPressed: () {
                                  Provider.of<ImagePickerProvider>(context,
                                          listen: false)
                                      .pickimage(source: ImageSource.gallery);
                                },
                                child: const Text('G A L L E R Y')),
                            ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.black)),
                                onPressed: () {
                                  Provider.of<ImagePickerProvider>(context,
                                          listen: false)
                                      .pickimage(source: ImageSource.camera);
                                },
                                child: const Text('C A M E R A')),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: namecontroller,
                            decoration: const InputDecoration(
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
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'A G E',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: emailcontroller,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'E M A I L',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: addresscontroller,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'A D D R E S S',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: coursecontroller,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'C O U R S E',
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
                              onPressed: () {
                                update();
                              },
                              child: const Text('U P D A T E'),
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
    );
  }

  update() async {
    final editedName = namecontroller.text.trim();
    final editedAge = agecontroller.text.trim();
    final editedEmail = emailcontroller.text.trim();
    final editedAddress = addresscontroller.text.trim();
    final editedCourse = coursecontroller.text.trim();
    final editedImage = Provider.of<ImagePickerProvider>(context, listen: false)
        .selectedimage
        ?.path;

    if (editedName.isEmpty ||
        editedAge.isEmpty ||
        editedEmail.isEmpty ||
        editedAddress.isEmpty ||
        editedCourse.isEmpty) {
      return;
    }
    final updated = Studentmodel(
        name: editedName,
        age: editedAge,
        email: editedEmail,
        address: editedAddress,
        course: editedCourse,
        image: editedImage);

    Provider.of<DbProvider>(context, listen: false)
        .editstudent(widget.index, updated);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Updated Successfully'),
      behavior: SnackBarBehavior.floating,
    ));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const DetailsScreen(),
    ));
  }
}
