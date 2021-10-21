import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/core/constants/api.dart';
import 'package:oikos/core/constants/routes.dart';
import 'package:oikos/features/auth/controllers/authController.dart';
import 'package:oikos/features/mesBien/controllers/ajoutFormController.dart';
import 'package:oikos/shared/widgets/button.dart';

class MonBien extends StatelessWidget {
  AjoutFormController ajoutFormController = Get.find();
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    final features = ajoutFormController.feat;

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
            'Mon bien'.toUpperCase(),
            style: AppTheme.appBarTitleTextStyle,
            textScaleFactor: 1,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: Get.width,
            height: 90,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  //ajoutBienFormModel.category==Categories.MAISON?'Maison':ajoutBienFormModel.category==Categories.APPARTEMENT?'Appartement':ajoutBienFormModel.category==Categories.ATELIER?'Atelier':ajoutBienFormModel.category==Categories.PROPRIETE?'Propriété':ajoutBienFormModel.category==Categories.?:ajoutBienFormModel.category==Categories.MAISON?:
                  '${ajoutFormController.ajoutBienFormModel.value.category} - ${ajoutFormController.ajoutBienFormModel.value.nbPiece} Pièces - ${ajoutFormController.ajoutBienFormModel.value.surface} m²',
                  style: AppTheme.whiteH6TextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      ajoutFormController.ajoutBienFormModel.value.street +
                          ', ' +
                          ajoutFormController.ajoutBienFormModel.value.city +
                          ', ' +
                          ajoutFormController.ajoutBienFormModel.value.country,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Multi',
                          fontSize: 11,
                          letterSpacing: 0.3),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text(
                        ajoutFormController.ajoutBienFormModel.value.price
                                .toString() +
                            ' €',
                        style: TextStyle(
                            color: Color(0xffE36A00),
                            fontFamily: 'Multi',
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            height: 1.2,
                            letterSpacing: 1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Divider(
                        height: 1,
                        color: Color(0xffD8D8D8),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/bed.svg',
                                color: Color(0xff2A2A43),
                                height: 30,
                                width: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '${ajoutFormController.ajoutBienFormModel.value.nbChambre} chambres',
                                  style: TextStyle(
                                      fontFamily: 'Multi',
                                      fontSize: 11,
                                      height: 1.25,
                                      color: Color(0xff9B9B9B)),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/cuisine.svg',
                                color: Color(0xff2A2A43),
                                height: 30,
                                width: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Cuisine',
                                  style: TextStyle(
                                      fontFamily: 'Multi',
                                      fontSize: 11,
                                      height: 1.25,
                                      color: Color(0xff9B9B9B)),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/sallon.svg',
                                color: Color(0xff2A2A43),
                                height: 30,
                                width: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Sallon',
                                  style: TextStyle(
                                      fontFamily: 'Multi',
                                      fontSize: 11,
                                      height: 1.25,
                                      color: Color(0xff9B9B9B)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Color(0xffD8D8D8),
                    ),
                    Container(
                      width: Get.width,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 50,
                        ),
                        addRepaintBoundaries: false,
                        physics: ScrollPhysics(parent: ScrollPhysics()),
                        padding: EdgeInsets.all(8),
                        shrinkWrap: true,
                        itemCount: features.length,
                        itemBuilder: (context, index) {
                          return featureTag(features[index]);
                        },
                      ),
                    ),
                    Container(
                      width: Get.width,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 90,
                        ),
                        addRepaintBoundaries: false,
                        physics: ScrollPhysics(parent: ScrollPhysics()),
                        padding: EdgeInsets.all(8),
                        shrinkWrap: true,
                        itemCount: ajoutFormController
                                .ajoutBienFormModel.value.fileBiens.length +
                            1,
                        itemBuilder: (context, index) {
                          if (index == 0) return buildAddPhoto(context);
                          return Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            child: Image.network(
                              'http://197.13.15.233:8787/api/v1/properties/mediatype-image/' +
                                  ajoutFormController.ajoutBienFormModel.value
                                      .fileBiens[index - 1]['id'],
                              headers: {
                                'Authorization':
                                    'Bearer ' + authController.token
                              },
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      height: 50,
                      width: Get.width,
                      child: CustomButton(
                        buttonContent:
                            'Ajouter un texte d\'annonce'.toUpperCase(),
                        onPressedFn: () {
                          Get.toNamed(Routes.ajouterDescription);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Align buildAddPhoto(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          DottedBorder(
            borderType: BorderType.Rect,
            dashPattern: [10, 15],
            color: AppTheme.kprimaryColor,
            strokeCap: StrokeCap.butt,
            strokeWidth: 2,
            child: Container(
              height: 90,
              width: 90,
              padding: const EdgeInsets.all(13.0),
              child: Icon(
                Icons.photo_size_select_actual_outlined,
                color: Colors.grey[350],
                size: 40,
              ),
            ),
          ),
          Positioned(
            left: -14,
            top: -10,
            child: Container(
              height: 30,
              width: 50,
              color: Colors.white,
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    size: 25,
                  ),
                  color: AppTheme.kprimaryColor,
                  onPressed: () {
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
                                    'Vous pouvez profiter de notre service Séance photo',
                                    style: AppTheme.formTitleBlackBoldTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 50,
                                          child: TextButton(
                                            onPressed: () {
                                              Get.toNamed(Routes.cameraPage);
                                            },
                                            child: Text(
                                                'd\'accord'.toUpperCase(),
                                                style: TextStyle(
                                                    color: AppTheme
                                                        .kprimaryColor)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 50,
                                          child: CustomButton(
                                            buttonContent:
                                                'non, merci'.toUpperCase(),
                                            onPressedFn: () {
                                              Get.back();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget featureTag(String feature) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/tick.svg'),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            feature,
            style: AppTheme.titleBlackBoldTextStyle,
          ),
        )
      ],
    );
  }
}
