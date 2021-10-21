import 'dart:io';

import 'package:get/get.dart';
import 'package:oikos/core/constants/api.dart';

class MonCompteEndPoint extends GetConnect {
  getImageID(String token) => get(
        API.SERVER_BASE_URL + '/user/me/picture',
        headers: {'Authorization': 'Bearer ' + token},
      );
  setImage(File file, String token) {
    final form = FormData({
      'file': MultipartFile(file, filename: 'id'),
    });
    put(
      API.SERVER_BASE_URL + '/user/me/picture',
      form,
      headers: {'Authorization': 'Bearer ' + token},
    );
  }
}
