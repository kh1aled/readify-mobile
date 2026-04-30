// This file is kept for legacy compatibility.
// Use ImagePicker() directly in your widgets/screens instead of this global.
// See profile_screen.dart for the correct usage pattern.

import 'dart:io';
import 'package:image_picker/image_picker.dart';

/// Picks an image from the gallery and returns it as a [File], or null if
/// the user cancelled. Prefer using [ImagePicker] directly in a widget.
Future<File?> pickImageFromGallery() async {
  final picked = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );
  if (picked == null) return null;
  return File(picked.path);
}
