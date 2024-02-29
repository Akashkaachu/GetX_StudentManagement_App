import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  Future<File?> pickImage(ImageSource option) async {
    File? image;
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: option);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    } else {
      print("No image is Selected");
    }
    return image;
  }
}
