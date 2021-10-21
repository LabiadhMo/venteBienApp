import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:oikos/features/auth/data/providers/AuthEndPoints.dart';

abstract class AuthenticationService extends GetxService {
  Future<Map> getCurrentUser(String t);
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class AuthenticationServiceImpl extends AuthenticationService {
  AuthEndPointsApi _authEndPointsApi = AuthEndPointsApi();

  @override
  Future<Map> getCurrentUser(String token) async {
    var response = await _authEndPointsApi.getUser(token);
    return response.body;
  }

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    Map<String, String> data = {
      'emailOrPhone': email.trim(),
      'password': password
    };
    var response = await _authEndPointsApi.signIn(data);
    if (response.hasError)
      throw AuthenticationException(
        message: response.body['apierror']['message'],
        errCode: response.statusCode,
      );
    return response.body['token'];
  }

  @override
  Future<void> signOut() {
    return null;
  }
}

class AuthenticationException implements Exception {
  final String message;
  final int errCode;

  AuthenticationException(
      {this.errCode = 999, this.message = 'Unknown error occurred. '});
}
