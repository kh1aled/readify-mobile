
import 'dart:io';
import 'package:image_picker/image_picker.dart';

File? image;

Future<void> pickImage() async {
  final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (picked != null) {
    image = File(picked.path);
  }
}