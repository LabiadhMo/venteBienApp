import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/core/constants/routes.dart';
import 'package:oikos/features/auth/controllers/signupController.dart';
import 'package:oikos/features/auth/data/models/User.dart';
import 'package:oikos/features/auth/data/repositories/loginPageRepository.dart';
import 'package:oikos/features/auth/utils/SignUpstatus.dart';
import 'package:oikos/shared/widgets/backgroundWidget.dart';
import 'package:oikos/shared/widgets/button.dart';
import 'package:oikos/shared/widgets/facebookLoginButton.dart';
import 'package:oikos/shared/widgets/formInputField.dart';
import 'package:oikos/shared/widgets/googleLoginButton.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController postalAdressController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final now = DateTime.now();
  DateTime selectedDate = DateTime.now();
  bool datePicked = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedRegion;
  List<String> region;
  LoginRepoImpl _repo = LoginRepoImpl();
  bool dataLoaded;
  bool viewPassword = false;
  Future<void> _selectDate(BuildContext context) async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950, 8),
      lastDate: DateTime(2022),
    );
    if (selectedDate != null)
      setState(() {
        datePicked = true;
      });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    List l = await _repo.getAllDepartments();
    region = (l.map((e) => e['name'].toString())).toList();
    setState(() {
      dataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(color: Colors.white, fontSize: 14);
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return BackgroundWidget(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 35, bottom: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: BackButton(
                            onPressed: () {
                              Get.back();
                            },
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 80.0),
                      //   child: SvgPicture.asset("assets/icons/oikos.svg"),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     SvgPicture.asset("assets/icons/facebook.svg"),
                      //     SizedBox(
                      //       width: 24,
                      //     ),
                      //     SvgPicture.asset("assets/icons/google.svg"),
                      //   ],
                      // ),
                      // Container(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Expanded(
                      //         child: Divider(
                      //           thickness: 2,
                      //           height: 2,
                      //           color: Colors.white,
                      //         ),
                      //         flex: 2,
                      //       ),
                      //       Expanded(
                      //         child: Text(
                      //           "OU",
                      //           textScaleFactor: 1,
                      //           style: TextStyle(
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 14),
                      //           textAlign: TextAlign.center,
                      //         ),
                      //         flex: 1,
                      //       ),
                      //       Expanded(
                      //         child: Divider(
                      //           thickness: 2,
                      //           height: 2,
                      //           color: Colors.white,
                      //         ),
                      //         flex: 2,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SvgPicture.asset('assets/icons/oikosim.svg'),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 35,
                          bottom: 5,
                          left: 35,
                          right: 35,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Prénom",
                            textScaleFactor: 1.0,
                            style: labelStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                          left: 35,
                          right: 35,
                        ),
                        child: FormInputField(
                          controller: prenomController,
                          labelText: "Prénom",
                          validator: (value) =>
                              value.isEmpty ? "Nom non valide" : null,
                          suffixIcon: SvgPicture.asset(
                            'assets/icons/profile.svg',
                            height: 5,
                            width: 5,
                            fit: BoxFit.scaleDown,
                            color: Color(0xffBEBEBE),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                          left: 35,
                          right: 35,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Nom de famille",
                            textScaleFactor: 1.0,
                            style: labelStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                          left: 35,
                          right: 35,
                        ),
                        child: FormInputField(
                          controller: nomController,
                          labelText: "Nom de famille",
                          validator: (value) =>
                              value.isEmpty ? "Nom non valide" : null,
                          suffixIcon: SvgPicture.asset(
                            'assets/icons/profile.svg',
                            height: 5,
                            width: 5,
                            fit: BoxFit.scaleDown,
                            color: Color(0xffBEBEBE),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                          left: 35,
                          right: 35,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Email",
                            textScaleFactor: 1.0,
                            style: labelStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                          left: 35,
                          right: 35,
                        ),
                        child: FormInputField(
                          suffixIcon: SvgPicture.asset(
                            'assets/icons/messageries.svg',
                            height: 5,
                            width: 5,
                            fit: BoxFit.scaleDown,
                            color: Color(0xffBEBEBE),
                          ),
                          controller: emailController,
                          labelText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value.isEmail ? null : "Email non valide",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                          left: 35,
                          right: 35,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Mot de passe",
                            textScaleFactor: 1.0,
                            style: labelStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                          left: 35,
                          right: 35,
                        ),
                        child: FormInputField(
                          controller: passwordController,
                          labelText: "Mot de passe",
                          obscureText: !viewPassword,
                          validator: (value) =>
                              value.isEmpty ? "Mot de passe non valide" : null,
                          suffixIcon: IconButton(
                            icon: Icon(
                              viewPassword == true
                                  ? Icons.visibility_off_outlined
                                  : Icons.remove_red_eye_outlined,
                              color: Color(0xffBEBEBE),
                            ),
                            onPressed: () {
                              setState(() {
                                viewPassword = !viewPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 40,
                          bottom: 0,
                          left: 0,
                          right: 0,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Information Personelles",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 40,
                          bottom: 5,
                          left: 35,
                          right: 35,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Date de naissance",
                            textScaleFactor: 1.0,
                            style: labelStyle,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                            height: 48,
                            width: Get.width - 70,
                            margin: const EdgeInsets.only(
                              top: 0,
                              bottom: 0,
                              left: 35,
                              right: 35,
                            ),
                            padding: EdgeInsets.only(right: 10, left: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  datePicked
                                      ? DateFormat.yMMMd().format(selectedDate)
                                      : "jj/mm/aaaa",
                                  textScaleFactor: 1.0,
                                  style: AppTheme.hintTextStyle,
                                ),
                                Icon(
                                  Icons.date_range_outlined,
                                  color: Color(0xffBEBEBE),
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                          left: 35,
                          right: 35,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Région",
                            style: labelStyle,
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                          left: 35,
                          right: 35,
                        ),
                        padding: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: DropdownButton<String>(
                          iconEnabledColor: Color(0xffBEBEBE),
                          isExpanded: true,
                          underline: Container(),
                          value: selectedRegion,
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "Région",
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          items: (dataLoaded == true
                                  ? region
                                  : <String>['A', 'B', 'C', 'D'])
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  value,
                                  textScaleFactor: 1.0,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (_) {
                            setState(() {
                              selectedRegion = _;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                          left: 35,
                          right: 35,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Adresse Postale",
                            textScaleFactor: 1.0,
                            style: labelStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                          left: 35,
                          right: 35,
                        ),
                        child: FormInputField(
                          validator: (value) =>
                              value.isEmpty ? "Adresse non valide" : null,
                          controller: postalAdressController,
                          labelText: "Adresse Postale",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                          left: 35,
                          right: 35,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Code Postale",
                            textScaleFactor: 1.0,
                            style: labelStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                          left: 35,
                          right: 35,
                        ),
                        child: FormInputField(
                          controller: zipCodeController,
                          labelText: "Code Postale",
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value.isEmpty ? "Code postale non valide" : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                          left: 35,
                          right: 35,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Numéro de Téléphone",
                            textScaleFactor: 1.0,
                            style: labelStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                          left: 35,
                          right: 35,
                        ),
                        child: FormInputField(
                          controller: phoneController,
                          labelText: "Numéro de Téléphone",
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value.isEmpty ? "Numéro non valide" : null,
                        ),
                      ),
                      GetBuilder<SignUpController>(
                          init: Get.find(),
                          builder: (_) {
                            if (_.state is SignUpLoading)
                              return CircularProgressIndicator();
                            return Container(
                              margin: EdgeInsets.only(
                                top: 45,
                                left: 65,
                                right: 65,
                                bottom: 60,
                              ),
                              height: 50,
                              width: Get.width,
                              child: CustomButton(
                                buttonContent: 'CONTINUER',
                                onPressedFn: () async {
                                  if ((formKey.currentState.validate()) &
                                      (selectedDate != null) &
                                      (selectedRegion != null)) {
                                    UserModel user = UserModel(
                                      email: emailController.text
                                          .trim()
                                          .toLowerCase(),
                                      password: passwordController.text,
                                      phoneNumber: phoneController.text,
                                      firstName: prenomController.text,
                                      lastName: nomController.text,
                                      zipCode: zipCodeController.text,
                                      street: postalAdressController.text,
                                      birthDate:
                                          selectedDate.toString().split(' ')[0],
                                      departmentIdentifier:
                                          region.indexOf(selectedRegion),
                                    );
                                    print(user.toJson());
                                    String code = await _
                                        .signUpWithEmailAndPassword(user);
                                    print(user.toJson());
                                    if (_.state is SignUpDone) {
                                      Response resp =
                                          await _.confirmSMSSignUpCode(
                                              code.split(' ').last);
                                      if (resp.statusCode == 200) {
                                        Get.defaultDialog(
                                          title: 'Done',
                                          content: Text(
                                            'Sign Up avec succée',
                                            textScaleFactor: 1.0,
                                          ),
                                          onConfirm: () {
                                            print('onConfirm worked');
                                            Get.toNamed(Routes.loginPage);
                                          },
                                          onCancel: () {
                                            print('onCancel worked');
                                            Get.toNamed(Routes.loginPage);
                                          },
                                        );
                                      }
                                    }
                                    if (_.state is SignUpFailure) {
                                      Get.defaultDialog(
                                          title: 'err',
                                          content: Text(
                                            (_.state as SignUpFailure)
                                                .err
                                                .toString(),
                                            textScaleFactor: 1.0,
                                          ));
                                    }
                                    print(user.toJson());
                                  }
                                },
                              ),
                            );
                          }),
                      Container(
                        padding: EdgeInsets.only(
                          left: 45,
                          bottom: 40,
                          right: 45,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 2,
                                height: 2,
                                color: Colors.white,
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  "Ou se connecter par votre compte",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    fontFamily: 'Multi',
                                    height: 1.35,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              flex: 12,
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 2,
                                height: 2,
                                color: Colors.white,
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 45.0, right: 45.0, bottom: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: GoogleLoginButton()),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(child: FacebookLoginButton()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
