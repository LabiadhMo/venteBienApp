import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/features/mesBien/controllers/ajoutFormController.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PriceOverViewScreen extends StatefulWidget {
  @override
  _PriceOverViewScreenState createState() => _PriceOverViewScreenState();
}

class _PriceOverViewScreenState extends State<PriceOverViewScreen> {
  int selectedPrice = -1;
  AjoutFormController ajoutFormController = Get.find();
  bool visible;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          buildEstimatedPriceTag(
            title: 'Prix Min',
            subtitle: 'de 1100€ à 1222€ le m2',
            price: '165 350 €',
            color: Color.fromRGBO(227, 106, 0, .5),
            value: 0,
            iconColor: Color.fromRGBO(227, 106, 0, 1),
          ),
          buildEstimatedPriceTag(
            title: 'Prix Moy',
            subtitle: 'de 1100€ à 1222€ le m2',
            price: '178 500 €',
            color: Color.fromRGBO(227, 146, 75, 1),
            value: 1,
            iconColor: Color.fromRGBO(227, 106, 0, .6),
          ),
          buildEstimatedPriceTag(
            title: 'Prix Max',
            subtitle: 'de 1100€ à 1222€ le m2',
            price: '192 000 €',
            color: Color.fromRGBO(227, 106, 0, 1),
            value: 2,
            iconColor: Color.fromRGBO(241, 180, 127, 1),
          ),
          Container(
            margin: EdgeInsets.only(top: 25, bottom: 30),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            height: 200,
            width: Get.width,
            decoration: BoxDecoration(
              color: Color.fromRGBO(79, 145, 191, .11),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 125,
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'OU',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Multi',
                            fontSize: 16,
                            height: 1.3,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Radio(
                          value: 3,
                          groupValue: selectedPrice,
                          onChanged: (v) {
                            setState(() {
                              selectedPrice = v;
                            });
                          }),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          height: 115,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(79, 145, 191, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mon prix souhaité',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                        color: Colors.white),
                                  ),
                                  Container(
                                      height: 40,
                                      width: 200,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: 'mon prix souhaité',
                                            hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  184, 184, 184, 1),
                                              fontFamily: 'Multi',
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: 0,
                                              height: 1.25,
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        238, 238, 238, 1),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      )),
                                  Text(
                                    'Plus d\'info',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      height: 1.3,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SvgPicture.asset(
                                'assets/icons/estimBien.svg',
                                height: 60,
                                color: Color.fromRGBO(0, 96, 162, 1),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Text(
              'Des Biens dans la même cathégorie',
              style: AppTheme.formTitleBlackBoldTextStyle,
            ),
          ),
          VisibilityDetector(
            key: Key('my-widget-key'),
            onVisibilityChanged: (visibilityInfo) {
              var visiblePercentage = visibilityInfo.visibleFraction * 100;
              //setState(() {
              //visiblePercentage > 90 ? visible = true : visible = false;
              //});
              debugPrint(
                  'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
            },
            child: Container(
              height: 165,
              width: Get.width,
              margin: EdgeInsets.only(left: 25, right: 25, bottom: 70),
              padding: EdgeInsets.all(15),
              foregroundDecoration: visible == true
                  ? null
                  : BoxDecoration(color: Color.fromRGBO(255, 255, 255, .83)),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color.fromRGBO(184, 184, 184, .5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .16),
                      blurRadius: 9,
                      offset: Offset(0, 2))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/h.png'),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'La Tour-en-Jarez 42580',
                        style: AppTheme.formTitleBlackBoldTextStyle,
                      ),
                      Text(
                        'à 23 km de Virigneux',
                        style: AppTheme.homeSubTitleTextStyle,
                      ),
                      Text(
                        '3 pièces - 162 m2',
                        style: TextStyle(
                          fontFamily: 'Multi',
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          height: 1.35,
                          color: Color.fromRGBO(155, 155, 155, 1),
                        ),
                      ),
                      Text(
                        '150 000€',
                        style: TextStyle(
                          fontFamily: 'Multi',
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          height: 1.35,
                          color: Color.fromRGBO(155, 155, 155, 1),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SvgPicture.asset(
                              'assets/icons/calendar.svg',
                              color: Color.fromRGBO(38, 153, 251, 1),
                            ),
                          ),
                          Text(
                            '12/12/2299',
                            style: TextStyle(
                              color: Color.fromRGBO(38, 153, 251, 1),
                              fontFamily: "Multi",
                              fontSize: 11,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SvgPicture.asset(
                              'assets/icons/horloge.svg',
                              color: Color.fromRGBO(38, 153, 251, 1),
                            ),
                          ),
                          Text(
                            '17:12',
                            style: TextStyle(
                              color: Color.fromRGBO(38, 153, 251, 1),
                              fontFamily: "Multi",
                              fontSize: 11,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildEstimatedPriceTag({
    Color iconColor,
    String price,
    String title,
    String subtitle,
    int value,
    Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 25,
        right: 25,
      ),
      child: Row(
        children: [
          Radio(
              value: value,
              groupValue: selectedPrice,
              onChanged: (v) {
                setState(() {
                  selectedPrice = v;
                  switch (v) {
                    case 0:
                      ajoutFormController.ajoutBienFormModel.value.price =
                          165350;
                      break;
                    case 1:
                      ajoutFormController.ajoutBienFormModel.value.price =
                          178500;
                      break;
                    case 2:
                      ajoutFormController.ajoutBienFormModel.value.price =
                          192000;
                      break;
                  }
                });
              }),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPrice = value;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                height: 100,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                              color: Colors.white),
                        ),
                        Text(
                          price,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                            height: 1.3,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            height: 1.3,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/icons/estimBien.svg',
                      height: 60,
                      color: iconColor,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
