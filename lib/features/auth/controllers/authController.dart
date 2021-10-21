import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oikos/core/constants/routes.dart';
import 'package:oikos/features/auth/data/models/userProfile.dart';
import 'package:oikos/features/auth/service/authenticationService.dart';
import 'package:oikos/features/auth/utils/authenticationstatus.dart';
import 'package:oikos/features/auth/data/models/User.dart';

class AuthController extends GetxController {
  UserModel userModel;
  String token;
  String id;
  final _authenticationStateStream = AuthenticationState().obs;
  final AuthenticationService _authenticationService;
  bool showPass = false;

  String name;
  AuthController(this._authenticationService);

  AuthenticationState get state => _authenticationStateStream.value;
  void st(st) => _authenticationStateStream.value = st;

  toggleShowPassword() {
    showPass = !showPass;
    update(['password']);
  }

  getUSer() async {
    print(token);
    Map m = await _authenticationService.getCurrentUser(token);

    print(m);
  }

  Future signInWithEmailPassword({
    @required String email,
    @required String password,
  }) async {
    _authenticationStateStream.value = AuthenticationLoading();
    try {
      final user = await _authenticationService.signInWithEmailAndPassword(
          email, password);
      token = user;
      print(token);
      Map m = await _authenticationService.getCurrentUser(token);
      var userp = UserProfile.fromJson(m);
      id = userp.id;
      name = userp.firstName;
      _authenticationStateStream.value = Authenticated(user: userp);
    } on AuthenticationException catch (e) {
      _authenticationStateStream.value = _authenticationStateStream.value =
          AuthenticationFailure(message: e.message);
      print(e.message);
    }
  }

  createAccount({@required UserModel user}) {}

  @override
  void onInit() {
    // _getAuthenticatedUser();
    super.onInit();
  }

  void signOut() async {
    await _authenticationService.signOut();
    _authenticationStateStream.value = UnAuthenticated();
    Get.offAllNamed(Routes.welcomePage);
  }

  void _getAuthenticatedUser() async {
    _authenticationStateStream.value = AuthenticationLoading();

    final user = await _authenticationService.getCurrentUser(token);

    if (user == null) {
      _authenticationStateStream.value = UnAuthenticated();
    } else {
      _authenticationStateStream.value = Authenticated(user: UserProfile());
    }
  }
}
