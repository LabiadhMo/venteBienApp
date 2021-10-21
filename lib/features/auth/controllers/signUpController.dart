import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:oikos/features/auth/data/models/User.dart';
import 'package:oikos/features/auth/data/repositories/loginPageRepository.dart';
import 'package:oikos/features/auth/service/SignUpService.dart';
import 'package:oikos/features/auth/utils/SignUpstatus.dart';

class SignUpController extends GetxController {
  final _signupStateStream = SignUpState().reactive;
  SignUpServiceImpl _signUpServiceImpl = SignUpServiceImpl();
  SignUpState get state => _signupStateStream.value;
  LoginRepoImpl _loginRepoImpl = LoginRepoImpl();
  List departments;
  List<String> departmentsNames;

  @override
  Future<void> onInit() async {
    super.onInit();
    departments = (await _loginRepoImpl.getAllDepartments());
    departmentsNames = departments.map((e) => e['name'].toString()).toList();
    print('done');
  }

  Future<String> signUpWithEmailAndPassword(UserModel user) async {
    Map map = {};
    _signupStateStream.value = SignUpLoading();
    update();
    try {
      map = await _signUpServiceImpl.signUpWithEmailAndPassword(user.toJson());
      _signupStateStream.value = SignUpDone(user: user);
      update();
    } on SignUpException catch (e) {
      _signupStateStream.value =
          SignUpFailure(message: e.message, err: e.errCode);
      update();
    }
    return map['message'];
  }

  Future confirmSMSSignUpCode(String code) {
    return _signUpServiceImpl.confirmSMScode(code);
  }
}
