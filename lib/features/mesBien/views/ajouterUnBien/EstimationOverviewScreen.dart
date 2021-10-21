import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/features/mesBien/controllers/ajoutFormController.dart';
import 'package:oikos/features/mesBien/controllers/bienOverviewController.dart';
import 'package:oikos/shared/widgets/button.dart';

class EstimationOverviewScreen extends StatelessWidget {
  EstimationOverviewScreen({
    Key key,
    @required this.features,
  }) : super(key: key);

  final List<String> features;
  BienOverviewController bienOverviewController = Get.find();
  AjoutFormController ajoutFormController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                //ajoutBienFormModel.value.category==Categories.MAISON?'Maison':ajoutBienFormModel.value.category==Categories.APPARTEMENT?'Appartement':ajoutBienFormModel.value.category==Categories.ATELIER?'Atelier':ajoutBienFormModel.value.category==Categories.PROPRIETE?'Propriété':ajoutBienFormModel.value.category==Categories.?:ajoutBienFormModel.value.category==Categories.MAISON?:
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
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    height: 50,
                    width: Get.width,
                    child: CustomButton(
                      onPressedFn: () {
                        Get.find<BienOverviewController>().toggleIsScreenOne();
                      },
                      buttonContent: 'estimation d\'oikos'.toUpperCase(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
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
