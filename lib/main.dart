import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:oikos/core/config/appRoutes.dart';
import 'package:oikos/features/auth/controllers/authController.dart';
import 'package:oikos/features/auth/controllers/signupController.dart';
import 'package:oikos/features/auth/service/authenticationService.dart';
import 'package:oikos/features/mesBien/views/ajouterUnBien/AjouterBien.dart';
import 'package:oikos/features/mesBien/views/compte/monComptePage.dart';
import 'package:oikos/shared/splash/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
//ss
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OIKOS',
      initialBinding: BindingsBuilder(() => {
            Get.put(AuthController(AuthenticationServiceImpl())),
          }), //
      getPages: AppRoutes.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Multi',
      ),
      home: Splash(),
    );
  }
}
