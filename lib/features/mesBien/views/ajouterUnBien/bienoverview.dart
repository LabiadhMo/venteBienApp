import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/core/constants/routes.dart';
import 'package:oikos/features/mesBien/controllers/ajoutFormController.dart';
import 'package:oikos/features/mesBien/controllers/bienOverviewController.dart';
import 'package:oikos/features/mesBien/data/models/ajoutBienFomModel.dart';
import 'package:oikos/features/mesBien/views/ajouterUnBien/EstimationOverviewScreen.dart';
import 'package:oikos/features/mesBien/views/ajouterUnBien/PriceOverviewScreen.dart';
import 'package:oikos/shared/widgets/bottomNavBar.dart';
import 'package:oikos/shared/widgets/button.dart';

class BienOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AjoutFormController ajoutFormController = Get.find();

    List<String> feat = ajoutFormController.feat;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                AppTheme.kAppBarGradient1,
                AppTheme.kAppBarGradient2
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
              icon: SvgPicture.asset('assets/icons/editpencilsquare.svg'),
              onPressed: () {})
        ],
        title: Center(
          child: Text(
            'Bien à estimer'.toUpperCase(),
            style: AppTheme.appBarTitleTextStyle,
            textScaleFactor: 1,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.find<BienOverviewController>().isScreenOne.value == false
                ? Get.find<BienOverviewController>().toggleIsScreenOne()
                : Get.back();
          },
        ),
      ),
      body: GetBuilder<BienOverviewController>(
          init: Get.find(),
          builder: (_) {
            if (_.isScreenOne.value)
              return EstimationOverviewScreen(features: feat);
            else
              return PriceOverViewScreen();
          }),
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: GetBuilder(
          init: Get.find<BienOverviewController>(),
          builder: (_) {
            if (_.isScreenOne.value == false)
              return Container(
                  height: 50,
                  width: 300,
                  child: CustomButton(
                      onPressedFn: () async {
                        int r = await ajoutFormController.insertPrice();
                        if (r == 1) {
                          showDialog(
                              barrierColor: Color.fromRGBO(0, 96, 162, .8),
                              context: context,
                              builder: (c) {
                                return Dialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 25, horizontal: 25),
                                    height: 270,
                                    width: 500,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/camera.svg',
                                          color: AppTheme.kprimaryColor,
                                          height: 45,
                                          width: 45,
                                        ),
                                        Text(
                                          'Prix validé',
                                          style: AppTheme
                                              .formTitleBlackBoldTextStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: TextButton(
                                            onPressed: () {
                                              Get.toNamed(Routes.monBienPage);
                                            },
                                            child: Text(
                                                'd\'accord'.toUpperCase(),
                                                style: TextStyle(
                                                    color: AppTheme
                                                        .kprimaryColor)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          showDialog(
                              barrierColor: Color.fromRGBO(0, 96, 162, .8),
                              context: context,
                              builder: (c) {
                                return Dialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 25, horizontal: 25),
                                    height: 270,
                                    width: 500,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/camera.svg',
                                          color: AppTheme.kprimaryColor,
                                          height: 45,
                                          width: 45,
                                        ),
                                        Text(
                                          'un erreur',
                                          style: AppTheme
                                              .formTitleBlackBoldTextStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: CustomButton(
                                            buttonContent:
                                                'non, merci'.toUpperCase(),
                                            onPressedFn: () {
                                              Get.back();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      },
                      buttonContent: 'Valider le prix'));
            else
              return Container(
                height: 0.0,
                width: 0.0,
              );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
