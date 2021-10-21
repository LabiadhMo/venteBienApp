import 'package:get/route_manager.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:oikos/core/constants/routes.dart';
import 'package:oikos/features/auth/controllers/signupController.dart';
import 'package:oikos/features/auth/views/login/login.dart';
import 'package:oikos/features/auth/views/signup/signupPage.dart';

import 'package:oikos/features/home/views/homePage.dart';
import 'package:oikos/features/home/views/messageries/messageriesScreen.dart';
import 'package:oikos/features/home/views/notifications/notificationsScreen.dart';
import 'package:oikos/features/mesBien/controllers/ajoutFormController.dart';
import 'package:oikos/features/mesBien/controllers/bienDetails.dart';
import 'package:oikos/features/mesBien/controllers/bienOverviewController.dart';
import 'package:oikos/features/mesBien/controllers/mesBienController.dart';
import 'package:oikos/features/mesBien/controllers/monCompteController.dart';
import 'package:oikos/features/mesBien/views/ajouterUnBien/AjouterBien.dart';
import 'package:oikos/features/mesBien/views/ajouterUnBien/ajouterDescription.dart';
import 'package:oikos/features/mesBien/views/ajouterUnBien/bienoverview.dart';
import 'package:oikos/features/mesBien/views/ajouterUnBien/cameraPage.dart';
import 'package:oikos/features/mesBien/views/ajouterUnBien/monbienpage.dart';
import 'package:oikos/features/mesBien/views/bienDetails/bienDetails.dart';
import 'package:oikos/features/mesBien/views/biens/mesBiensPage.dart';
import 'package:oikos/features/mesBien/views/compte/monComptePage.dart';
import 'package:oikos/shared/splash/splash.dart';
import 'package:oikos/shared/welcome/welcome.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => Splash()),
    GetPage(name: Routes.welcomePage, page: () => WelcomeScreen()),
    GetPage(name: Routes.loginPage, page: () => LoginScreen()),
    GetPage(
        name: Routes.signupPage,
        page: () => SignUp(),
        binding: BindingsBuilder(
          () => Get.lazyPut(() => SignUpController()),
        )),
    GetPage(name: Routes.homePage, page: () => HomePage()),
    GetPage(name: Routes.notificationPage, page: () => NotificationsScreen()),
    GetPage(name: Routes.messageriesPage, page: () => MessageriesScreen()),
    GetPage(
      name: Routes.monComptePage,
      page: () => MonCompteScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(
          () => MonCompteController(),
        ),
      ),
    ),
    GetPage(
        name: Routes.mesBiensPage,
        page: () => MesBiensScreen(),
        binding: BindingsBuilder(() => Get.lazyPut(() => MesBienController()))),
    GetPage(
        name: Routes.ajoutBienPage,
        page: () => AjouterUnBien(),
        binding:
            BindingsBuilder(() => Get.lazyPut(() => AjoutFormController()))),
    GetPage(
        name: Routes.bienOverviewPage,
        page: () => BienOverview(),
        binding:
            BindingsBuilder(() => Get.lazyPut(() => BienOverviewController()))),
    GetPage(name: Routes.monBienPage, page: () => MonBien()),
    GetPage(name: Routes.cameraPage, page: () => CameraPage()),
    GetPage(name: Routes.ajouterDescription, page: () => AjouterDescription()),
    GetPage(
        name: Routes.BienDetails,
        page: () => BienDetails(),
        binding:
            BindingsBuilder(() => Get.lazyPut(() => BienDetailsController()))),
  ];
}
