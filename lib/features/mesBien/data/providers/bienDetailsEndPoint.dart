import 'package:get/get.dart';
import 'package:oikos/core/constants/api.dart';

class BienDetailsEndPoint extends GetConnect {
  getProperty(String id, String token) async {
    Response response = await get(
      API.SERVER_BASE_URL + '/properties/' + id,
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response.body;
  }
}
