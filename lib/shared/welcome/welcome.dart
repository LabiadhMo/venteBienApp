import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/core/constants/routes.dart';

import 'package:oikos/shared/widgets/backgroundWidget.dart';
import 'package:oikos/shared/widgets/button.dart';
import 'package:oikos/shared/widgets/facebookLoginButton.dart';
import 'package:oikos/shared/widgets/googleLoginButton.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: (Get.height / 2) - 150,
              ),
              SvgPicture.asset(
                'assets/icons/oikosim.svg',
                height: 125,
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.loginPage);
                        },
                        child: Text(
                          "SE CONNECTER",
                          style: AppTheme.buttonExtraBoldTextStyle,
                          textScaleFactor: 1.0,
                        )),
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    child: CustomButton(
                        onPressedFn: () {
                          Get.toNamed(Routes.signupPage);
                        },
                        buttonContent: "CREER UN COMPTE"),
                  ),
                ],
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 45, bottom: 40, right: 45, top: 100),
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
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
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
              Padding(
                padding: const EdgeInsets.only(top: 170.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Conditions d'utilisations",
                      style: AppTheme.smallTextStyle,
                      textScaleFactor: 1.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0),
                      child:
                          SvgPicture.asset("assets/icons/welcomeEllipse.svg"),
                    ),
                    Text(
                      " Oikos © 2021",
                      style: AppTheme.smallTextStyle,
                      textScaleFactor: 1.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
