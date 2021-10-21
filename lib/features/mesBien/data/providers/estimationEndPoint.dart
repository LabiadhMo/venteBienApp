import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:oikos/core/constants/api.dart';
import 'package:oikos/features/mesBien/controllers/ajoutFormController.dart';
import 'package:oikos/features/mesBien/data/models/ajoutBienFomModel.dart';

class EstimationEndPoint extends GetConnect {
  AjoutFormController ajoutFormController = Get.find();
  Future<Map<String, dynamic>> getProperty(String token, Map property) async {
    Response r = await post(
      API.SERVER_BASE_URL + '/properties/create',
      property,
      headers: {'Authorization': 'Bearer ' + token},
      uploadProgress: (f) {
        ajoutFormController.setprogress(f.toInt());
      },
    );
    print(r.body.toString());
    return r.body;
  }

  Future<List> getPropertyFiles(String token, String property) async {
    Response r = await get(
      API.SERVER_BASE_URL + '/properties/$property/files',
      headers: {'Authorization': 'Bearer ' + token},
    );
    print(r.body.toString());
    return r.body;
  }

  uploadFile(String id, String token, File image) async {
    final form = FormData({
      'file': MultipartFile(image, filename: id),
    });
    Response r = await post(
      API.SERVER_BASE_URL + '/properties/upload/' + id,
      form,
      headers: {'Authorization': 'Bearer ' + token},
    );
    return r.body;
  }

  updateBien(String id, String token, Map body) async {
    Response r = await put(
      API.SERVER_BASE_URL + '/properties/$id',
      body,
      headers: {'Authorization': 'Bearer ' + token},
    );
    print(r.body.toString());
    return r;
  }

  getAddressFromLatLng(double lat, double lng) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url =
        '$_host?key=AIzaSyDT3J4Gm53kFuQtkqnAVQC3kt5HpEyE5K0&language=en&latlng=$lat,$lng';
    if (lat != null && lng != null) {
      var response = await get(url);
      if (response.statusCode == 200) {
        print(response.body.toString());

        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        return _formattedAddress;
      } else
        print(response.body.toString());
    } else
      return null;
  }
}
