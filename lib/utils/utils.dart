import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  ImagePicker picker = ImagePicker();
  XFile? file = await picker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  debugPrint('Some error occurred');
}
