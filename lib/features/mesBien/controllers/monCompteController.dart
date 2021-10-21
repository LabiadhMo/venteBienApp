import 'dart:io';

import 'package:get/get.dart';
import 'package:oikos/features/auth/controllers/authController.dart';
import 'package:oikos/features/mesBien/data/providers/MonCompteEndPoint.dart';

class MonCompteController extends GetxController {
  String profileImageURL = 'vide';
  bool isProfileInitialized = false;
  MonCompteEndPoint _monCompteEndPoint = MonCompteEndPoint();
  AuthController _authController = Get.find();

  initProfile() async {
    Response response =
        await _monCompteEndPoint.getImageID(_authController.token);
    if (response.statusCode == 200) {
      profileImageURL = response.body;
      isProfileInitialized = true;
    }
  }

  Future<void> insertPhoto(String path) async {
    Response response =
        await _monCompteEndPoint.setImage(File(path), _authController.token);
  }
}
