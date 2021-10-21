import 'package:get/get_connect.dart';
import 'package:oikos/core/constants/api.dart';

class AuthEndPointsApi extends GetConnect {
  Future<Response> signUpSeller(Map data) => post(
        API.SERVER_BASE_URL + '/security/signup/seller',
        data,
      );
  Future<Response> signUpBuyer(Map data) => post(
        API.SERVER_BASE_URL + '/security/signup/buyer',
        data,
      );
  Future<Response> signIn(Map data) => post(
        API.SERVER_BASE_URL + '/security/signin',
        data,
      );
  Future<Response> resetPassword(Map data, String token) => post(
        API.SERVER_BASE_URL + '/security/resetpassword/$token',
        data,
      );
  Future<Response> passwordForgetten(Map data) => post(
        API.SERVER_BASE_URL + '/security/passwordforgetten',
        data,
      );
  Future<Response> sendSMSConfirm(String phonenumber) => get(
        API.SERVER_BASE_URL + '/security/smsconfirm/$phonenumber/resend',
      );
  Future<Response> confirmSMSCode(String confirmationCode) => get(
        API.SERVER_BASE_URL + '/security/smsconfirm/$confirmationCode',
      );
  Future<Response> refreshToken() => get(
        API.SERVER_BASE_URL + '/security/refreshToken',
      );
  Future<Response> sendMailConfirm(String email) => get(
        API.SERVER_BASE_URL + '/security/mailconfirm/$email/resend',
      );
  Future<Response> confirmMailCode(String confirmationCode) => get(
        API.SERVER_BASE_URL + '/security/mailconfirm/$confirmationCode',
      );
  getUser(String token) => get(API.SERVER_BASE_URL + '/user/me',
      headers: {'Authorization': 'Bearer ' + token});
  Future<Response> getDepartments() =>
      get(API.SERVER_BASE_URL + '/public/departments');
}
