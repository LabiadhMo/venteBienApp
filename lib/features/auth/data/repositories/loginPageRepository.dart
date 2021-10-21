import 'package:oikos/features/auth/data/providers/AuthEndPoints.dart';

abstract class LoginRepo {
  Future<List> getAllDepartments();
}

class LoginRepoImpl extends LoginRepo {
  AuthEndPointsApi _authEndPointsApi = AuthEndPointsApi();
  @override
  Future<List> getAllDepartments() async {
    var response = await _authEndPointsApi.getDepartments();
    List list = response.body;
    return list;
  }
}
