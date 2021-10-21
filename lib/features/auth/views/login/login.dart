import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:oikos/core/config/theme.dart';
import 'package:oikos/features/auth/controllers/authController.dart';
import 'package:oikos/features/auth/utils/authenticationstatus.dart';

import 'package:oikos/shared/widgets/backgroundWidget.dart';
import 'package:oikos/shared/widgets/button.dart';
import 'package:oikos/shared/widgets/formInputField.dart';
import 'package:oikos/shared/widgets/facebookLoginButton.dart';
import 'package:oikos/shared/widgets/googleLoginButton.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 35,
                  ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: SvgPicture.asset("assets/icons/oikos.svg"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0, left: 35),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Adresse Email",
                      textScaleFactor: 1.0,
                      style: AppTheme.formTextStyle,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                  child: FormInputField(
                    suffixIcon: SvgPicture.asset(
                      'assets/icons/profile.svg',
                      height: 5,
                      width: 5,
                      fit: BoxFit.scaleDown,
                      color: Color(0xffBEBEBE),
                    ),
                    validator: (value) =>
                        value.isEmpty ? "email invalide" : null,
                    labelText: "Adresse Email",
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    controller: emailEditingController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0, bottom: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mot de passe",
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.left,
                      style: AppTheme.formTextStyle,
                    ),
                  ),
                ),
                GetBuilder<AuthController>(
                    init: Get.find(),
                    id: 'password',
                    builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        child: FormInputField(
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _.showPass
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Color(0xffBEBEBE),
                            ),
                            onPressed: () => _.toggleShowPassword(),
                          ),
                          validator: (value) =>
                              value.isNotEmpty ? null : 'Mot de passe invalide',
                          labelText: "Mot de passe",
                          obscureText: !_.showPass,
                          controller: passwordEditingController,
                        ),
                      );
                    }),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, left: 45),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Mot de passe oublié ?",
                        style: AppTheme.formTextStyle,
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ),
                ),
                GetX<AuthController>(
                  init: Get.find<AuthController>(),
                  builder: (_) {
                    print(_.state);
                    return Container(
                      key: GlobalKey(),
                      margin: EdgeInsets.only(
                        top: 35,
                        left: 40,
                        right: 40,
                        bottom: 0,
                      ),
                      height: 50,
                      width: Get.width,
                      child: (_.state is AuthenticationLoading)
                          ? CircularProgressIndicator()
                          : CustomButton(
                              onPressedFn: () async {
                                if (_formKey.currentState.validate()) {
                                  await _.signInWithEmailPassword(
                                    email: emailEditingController.text
                                        .trim()
                                        .toLowerCase(),
                                    password: passwordEditingController.text,
                                  );

                                  if (_.state is AuthenticationFailure) {
                                    print('xxxx');
                                    Get.defaultDialog(
                                      title: ('err'),
                                      content: Text(
                                        (_.state as AuthenticationFailure)
                                            .message,
                                        textScaleFactor: 1.0,
                                      ),
                                    );
                                  }
                                  if (_.state is Authenticated)
                                    Get.toNamed('/Home');
                                }
                              },
                              buttonContent: "CONTINUER",
                            ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous n'avez pas un compte  ? ",
                        style: AppTheme.smallTextStyle,
                        textScaleFactor: 1.0,
                      ),
                      Text(
                        "Créer un compte",
                        style: AppTheme.smallTextStyle,
                        textScaleFactor: 1.0,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 45, bottom: 40, right: 45, top: 100),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 45.0, right: 45.0, bottom: 160),
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
      ),
    );
  }
}
