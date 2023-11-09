import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  File? selectedimage;

  pickimage({required source}) async {
    final returnedimage = await ImagePicker().pickImage(source: source);

    selectedimage = File(returnedimage!.path);
    notifyListeners();
  }
}
