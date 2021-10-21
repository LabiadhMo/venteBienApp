import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:oikos/core/constants/routes.dart';
import 'package:oikos/shared/widgets/backgroundWidget.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 4), onDoneLoading);
  }

  onDoneLoading() async {
    print("Done Loadding");
    Get.offAndToNamed(Routes.welcomePage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BackgroundWidget(
        child: Container(
          alignment: Alignment.center,
          child: SvgPicture.asset("assets/icons/oikosim.svg"),
        ),
      ),
    );
  }
}
