import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  /// Value Notifiers
  ValueNotifier<bool> emailTextfieldIsActive = ValueNotifier(false);
  ValueNotifier<bool> contactNumberTextfieldIsActive = ValueNotifier(false);
  ValueNotifier<bool> emergencyNumberTextfieldIsActive = ValueNotifier(false);

  File? profileImageFile;

  void inActiveAllfields() {
    emailTextfieldIsActive.value = false;
    contactNumberTextfieldIsActive.value = false;
    emergencyNumberTextfieldIsActive.value = false;
  }

  getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
}
