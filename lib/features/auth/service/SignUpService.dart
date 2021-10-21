import 'package:get/get_connect.dart';
import 'package:oikos/features/auth/data/providers/AuthEndPoints.dart';

abstract class SignUpService {
  Future<Map> signUpWithEmailAndPassword(Map data);
}

class SignUpServiceImpl extends SignUpService {
  AuthEndPointsApi _authEndPointsApi = AuthEndPointsApi();
  Future<Response> confirmSMScode(String code) async {
    var response = await _authEndPointsApi.confirmSMSCode(code);
    return response;
  }

  @override
  Future<Map> signUpWithEmailAndPassword(Map data) async {
    var response = await _authEndPointsApi.signUpSeller(data);
    if (response.hasError)
      throw SignUpException(
        message: response.body['message'],
        errCode: response.statusCode,
      );
    return response.body;
  }
}

class SignUpException implements Exception {
  final String message;
  final int errCode;

  SignUpException(
      {this.errCode = 999, this.message = 'Unknown error occurred. '});
}
