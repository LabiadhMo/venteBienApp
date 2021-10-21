import 'package:get/get.dart';
import 'package:oikos/core/constants/api.dart';

class MesBienEndPoint extends GetConnect {
  Future<List> fetchAllProperties(String token) async {
    Response r = await get(
      API.SERVER_BASE_URL + '/properties/myproperties',
      headers: {'Authorization': 'Bearer ' + token},
    );
    print(r.body.toString());
    return r.body;
  }

  Future bienDelete(String id, String token) async {
    Response r = await delete(
      API.SERVER_BASE_URL + '/properties/' + id,
      headers: {'Authorization': 'Bearer ' + token},
    );
    print(r.body.toString());
    return r;
  }
}
