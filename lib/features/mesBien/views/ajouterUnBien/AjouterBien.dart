import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/core/constants/routes.dart';
import 'package:oikos/features/mesBien/controllers/ajoutFormController.dart';
import 'package:oikos/features/mesBien/data/models/ajoutBienFomModel.dart';
import 'package:oikos/shared/widgets/bottomNavBar.dart';
import 'package:oikos/shared/widgets/button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AjouterUnBien extends StatefulWidget {
  @override
  _AjouterUnBienState createState() => _AjouterUnBienState();
}

class _AjouterUnBienState extends State<AjouterUnBien> {
  AjoutFormController ajoutFormController;

  Map homeFeatures = {
    'Cuisine': false,
    'Sallon': false,
    'Terasse': false,
    'Garage': false,
    'Balcon': false,
    'Cave': false,
    'Jardin': false,
    'Piscine': false,
  };
  List<String> vue = ['VIS_A_VIS', 'DEGAGEE', 'EXCEPTIONNELLE'];
  List<String> standing = ['MOYEN', 'STANDARD', 'Exceptionnel'];
  List<String> emplacement = ['Bruyant', 'Standard', 'Calme'];
  Map<String, String> categories = {
    'Maison': 'Maison'.toUpperCase(),
    'Villa': 'Villa'.toUpperCase(),
    'Appartement': 'Appartement'.toUpperCase(),
    'Atelier': 'Atelier'.toUpperCase(),
    'Propriété': 'Propriete'.toUpperCase(),
    'Viager': 'Viager'.toUpperCase(),
  };

  Map exportation = {
    'Nord': false,
    'Est': false,
    'Sud': false,
    'Ouest': false,
  };

  TextEditingController surfaceTextController = TextEditingController();
  TextEditingController constructionDateController = TextEditingController();

  TextEditingController surfaceTerrainTextController = TextEditingController();
  TextEditingController surfaceSejourTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();

  GlobalKey circularindicator = GlobalKey();
  initEdit() async {
    if ((await ajoutFormController.serProperty()) == 1) {
      addressTextController.text =
          ajoutFormController.ajoutBienFormModel.value.street +
              ', ' +
              ajoutFormController.ajoutBienFormModel.value.city +
              ', ' +
              ajoutFormController.ajoutBienFormModel.value.country;
      homeFeatures['Cuisine'] =
          ajoutFormController.ajoutBienFormModel.value.cuisine;
      homeFeatures['Sallon'] =
          ajoutFormController.ajoutBienFormModel.value.sallon;

      homeFeatures['Terasse'] =
          ajoutFormController.ajoutBienFormModel.value.terasse;

      homeFeatures['Balcon'] =
          ajoutFormController.ajoutBienFormModel.value.balcon;

      homeFeatures['Jardin'] =
          ajoutFormController.ajoutBienFormModel.value.jardin;

      homeFeatures['Garage'] =
          ajoutFormController.ajoutBienFormModel.value.garage;
      homeFeatures['Cave'] = ajoutFormController.ajoutBienFormModel.value.cave;
      homeFeatures['Piscine'] =
          ajoutFormController.ajoutBienFormModel.value.piscine;

      exportation['Nord'] =
          ajoutFormController.ajoutBienFormModel.value.exportationNord;
      exportation['Sud'] =
          ajoutFormController.ajoutBienFormModel.value.exportationSud;
      exportation['Est'] =
          ajoutFormController.ajoutBienFormModel.value.exportationEst;
      exportation['Ouest'] =
          ajoutFormController.ajoutBienFormModel.value.exportationOuest;
      surfaceTextController.text =
          ajoutFormController.ajoutBienFormModel.value.surface.toString();
      constructionDateController.text = ajoutFormController
          .ajoutBienFormModel.value.constructionDate
          .toString();
      surfaceTerrainTextController.text = ajoutFormController
          .ajoutBienFormModel.value.surfaceTerrain
          .toString();
      surfaceSejourTextController.text =
          ajoutFormController.ajoutBienFormModel.value.surfaceSejour.toString();
      ajoutFormController.toggleEditInit();
    }
  }

  @override
  void initState() {
    super.initState();
    ajoutFormController = Get.find();
    if (ajoutFormController.editInitialized == false) {
      final arguments = Get.arguments;
      if (arguments == true) {
        ajoutFormController.isAddNew = true;
      } else {
        ajoutFormController.isAddNew = false;
        ajoutFormController.ajoutBienFormModel.value.id = arguments;
        initEdit();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: Center(
          child: Text(
            ajoutFormController.isAddNew == true
                ? 'Ajouter un bien'.toUpperCase()
                : 'modifier un bien'.toUpperCase(),
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
      body: Stack(
        children: [
          GetBuilder<AjoutFormController>(
              init: ajoutFormController,
              builder: (_) {
                if (_.addressInitialized)
                  addressTextController.text = _.currentAddress;

                if ((_.isAddNew == false) && (_.editInitialized == false))
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Vous-êtes le propriétaire de ce bien?',
                            style: AppTheme.formTitleBlackBoldTextStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: true,
                                groupValue: _.ajoutBienFormModel.value.isOwner,
                                onChanged: (v) {
                                  _.toggleIsowner();
                                }),
                            InkWell(
                              child: Text('Oui'),
                              onTap: () {
                                if (_.ajoutBienFormModel.value.isOwner == false)
                                  _.toggleIsowner();
                              },
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Radio(
                                value: false,
                                groupValue: _.ajoutBienFormModel.value.isOwner,
                                onChanged: (v) {
                                  _.toggleIsowner();
                                }),
                            InkWell(
                              child: Text('Non'),
                              onTap: () {
                                if (_.ajoutBienFormModel.value.isOwner == true)
                                  _.toggleIsowner();
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15, top: 20),
                          child: Text(
                            'Cathégorie de Bien',
                            style: AppTheme.formTitleBlackBoldTextStyle,
                          ),
                        ),
                        Container(
                          height: 80,
                          width: Get.width,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 30,
                            ),
                            addRepaintBoundaries: false,
                            physics: ScrollPhysics(
                                parent: NeverScrollableScrollPhysics()),
                            padding: EdgeInsets.all(8),
                            shrinkWrap: true,
                            itemCount: categories.keys.length,
                            itemBuilder: (context, index) {
                              return buildCategoryTag(index, _);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15, top: 20),
                          child: Text(
                            'Emplacement de Bien',
                            style: AppTheme.formTitleBlackBoldTextStyle,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: Get.width,
                          child: TextField(
                            controller: addressTextController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.gps_fixed,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  if (_.addressInitialized == false)
                                    _.printloc();
                                },
                              ),
                              errorStyle: TextStyle(color: Colors.red),
                              fillColor: Color.fromRGBO(247, 247, 247, 1),
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                left: 20.0,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              hintText: 'Adresse',
                              hintStyle: const TextStyle(
                                  fontFamily: 'Multi',
                                  color: Color(0xff959595),
                                  fontSize: 14,
                                  height: 1.2,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 50,
                        //   width: Get.width,
                        //   decoration: BoxDecoration(
                        //       color: Color(0xffF7F7F7),
                        //       border: Border.all(
                        //         color: Color(0xffEEEEEE),
                        //         width: 1,
                        //       ),
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //             vertical: 15, horizontal: 20),
                        //         child: Text(
                        //           _.currentAddress,
                        //           style: TextStyle(
                        //             fontFamily: 'Multi',
                        //             fontSize: 13,
                        //             color: Color(0xff959595),
                        //             height: 1.2,
                        //           ),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: EdgeInsets.all(0),
                        // child: IconButton(
                        //   icon: Icon(
                        //     Icons.gps_fixed,
                        //     size: 20,
                        //   ),
                        //   onPressed: () {},
                        // ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nombre de pièces',
                                style: AppTheme.formTitleBlackBoldTextStyle,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 50),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        color: Color(0xff08C277),
                                      ),
                                      onPressed: () {
                                        _.updateNbPiece(AddOrSub.SUB);
                                      },
                                    ),
                                    Text(_.ajoutBienFormModel.value.nbPiece
                                        .toInt()
                                        .toString()),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Color(0xff08C277),
                                      ),
                                      onPressed: () {
                                        _.updateNbPiece(AddOrSub.ADD);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nombre de chambre',
                              style: AppTheme.formTitleBlackBoldTextStyle,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Color(0xff08C277),
                                    ),
                                    onPressed: () {
                                      _.updateNbChambre(AddOrSub.SUB);
                                    },
                                  ),
                                  Text(_.ajoutBienFormModel.value.nbChambre
                                      .toInt()
                                      .toString()),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Color(0xff08C277),
                                    ),
                                    onPressed: () {
                                      _.updateNbChambre(AddOrSub.ADD);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: Get.width - 40,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(30, 197, 1, .22),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(Icons.info_outline_rounded),
                              ),
                              Flexible(
                                child: Text(
                                  'La cuisine , la salle de bain et les toilettes ne sont pas à prendre en compte',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Multi',
                                    fontSize: 13,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0,
                                    height: 1.25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Nombre des places de parking',
                                style: AppTheme.formTitleBlackBoldTextStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Color(0xff08C277),
                                    ),
                                    onPressed: () {
                                      _.updateNbParking(AddOrSub.SUB);
                                    },
                                  ),
                                  Text(_.ajoutBienFormModel.value.nbParking
                                      .toInt()
                                      .toString()),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Color(0xff08C277),
                                    ),
                                    onPressed: () {
                                      _.updateNbParking(AddOrSub.ADD);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 230,
                          width: Get.width,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 50,
                            ),
                            addRepaintBoundaries: false,
                            physics: ScrollPhysics(
                                parent: NeverScrollableScrollPhysics()),
                            padding: EdgeInsets.all(8),
                            shrinkWrap: true,
                            itemCount: homeFeatures.length,
                            itemBuilder: (context, index) {
                              return buildSwitchContainer(index);
                            },
                          ),
                        ),
                        Text(
                          'Surface m²',
                          style: AppTheme.titleBlackBoldTextStyle,
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: surfaceTextController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.red),
                              fillColor: Color.fromRGBO(247, 247, 247, 1),
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                left: 20.0,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              hintText: 'Surface en m²',
                              hintStyle: const TextStyle(
                                  fontFamily: 'Multi',
                                  color: Color(0xff959595),
                                  fontSize: 14,
                                  height: 1.2,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Text(
                            'Année de construction',
                            style: AppTheme.titleBlackBoldTextStyle,
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: constructionDateController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.red),
                              fillColor: Color.fromRGBO(247, 247, 247, 1),
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                left: 20.0,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              // suffixIcon: Icon(
                              //   Icons.keyboard_arrow_down_rounded,
                              //   color: Color(0xff959595),
                              // ),
                              hintText: '1900',
                              hintStyle: const TextStyle(
                                  fontFamily: 'Multi',
                                  color: Color(0xff959595),
                                  fontSize: 14,
                                  height: 1.2,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                            top: 40,
                          ),
                          child: Text(
                            'Des travaux à prévoir',
                            style: AppTheme.formTitleBlackBoldTextStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: true,
                                groupValue:
                                    _.ajoutBienFormModel.value.futureTraveaux,
                                onChanged: (v) {
                                  _.toggleFutureTraveaux();
                                }),
                            GestureDetector(
                              child: Text('Oui'),
                              onTap: () {
                                if (_.ajoutBienFormModel.value.futureTraveaux ==
                                    true) _.toggleFutureTraveaux();
                              },
                            ),
                            Radio(
                                value: false,
                                groupValue:
                                    _.ajoutBienFormModel.value.futureTraveaux,
                                onChanged: (v) {
                                  _.toggleFutureTraveaux();
                                }),
                            GestureDetector(
                              child: Text('Non'),
                              onTap: () {
                                if (_.ajoutBienFormModel.value.futureTraveaux ==
                                    true) _.toggleFutureTraveaux();
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Text(
                            'Surface en m2 de terrain ( Bâti de la maison inclus )',
                            style: AppTheme.titleBlackBoldTextStyle,
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: surfaceTerrainTextController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.red),
                              fillColor: Color.fromRGBO(247, 247, 247, 1),
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                left: 20.0,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              hintText: 'Surface m2',
                              hintStyle: const TextStyle(
                                  fontFamily: 'Multi',
                                  color: Color(0xff959595),
                                  fontSize: 14,
                                  height: 1.2,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Text(
                            'Surface en m2 de séjour',
                            style: AppTheme.titleBlackBoldTextStyle,
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: surfaceSejourTextController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.red),
                              fillColor: Color.fromRGBO(247, 247, 247, 1),
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                left: 20.0,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0,
                                ),
                              ),
                              hintText: 'Surface  m2',
                              hintStyle: const TextStyle(
                                  fontFamily: 'Multi',
                                  color: Color(0xff959595),
                                  fontSize: 14,
                                  height: 1.2,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                            top: 40,
                          ),
                          child: Text(
                            'Avez-vous une dépendance ?',
                            style: AppTheme.formTitleBlackBoldTextStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: true,
                                groupValue:
                                    _.ajoutBienFormModel.value.dependance,
                                onChanged: (v) {
                                  _.toggleDependance();
                                }),
                            GestureDetector(
                              child: Text('Oui'),
                              onTap: () {
                                if (_.ajoutBienFormModel.value.dependance ==
                                    false) _.toggleDependance();
                              },
                            ),
                            Radio(
                                value: false,
                                groupValue:
                                    _.ajoutBienFormModel.value.dependance,
                                onChanged: (v) {
                                  _.toggleDependance();
                                }),
                            GestureDetector(
                              child: Text('Non'),
                              onTap: () {
                                if (_.ajoutBienFormModel.value.dependance ==
                                    true) _.toggleDependance();
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Text(
                            'Exportation de votre Bien',
                            style: AppTheme.titleBlackBoldTextStyle,
                          ),
                        ),
                        Container(
                          height: 130,
                          width: Get.width,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 50,
                            ),
                            addRepaintBoundaries: false,
                            physics: ScrollPhysics(
                                parent: NeverScrollableScrollPhysics()),
                            padding: EdgeInsets.all(8),
                            shrinkWrap: true,
                            itemCount: exportation.length,
                            itemBuilder: (context, index) {
                              return buildSwitchExportationContainer(index);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                            top: 40,
                          ),
                          child: Text(
                            'La vue de votre Bien',
                            style: AppTheme.formTitleBlackBoldTextStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: vue[0],
                                groupValue: _.ajoutBienFormModel.value.vue,
                                onChanged: (v) {
                                  _.updateSelectedVue(vue[0]);
                                }),
                            GestureDetector(
                              child: Text('Vis-à-vis'),
                              onTap: () => _.updateSelectedVue(vue[0]),
                            ),
                            Radio(
                                value: vue[1],
                                groupValue: _.ajoutBienFormModel.value.vue,
                                onChanged: (v) {
                                  _.updateSelectedVue(vue[1]);
                                }),
                            GestureDetector(
                              child: Text('Dégagée'),
                              onTap: () => _.updateSelectedVue(vue[1]),
                            ),
                            Radio(
                                value: vue[2],
                                groupValue: _.ajoutBienFormModel.value.vue,
                                onChanged: (v) {
                                  _.updateSelectedVue(vue[2]);
                                }),
                            GestureDetector(
                              child: Text('Exceptionnelle'),
                              onTap: () => _.updateSelectedVue(vue[2]),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: Get.width - 40,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(30, 197, 1, .22),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(Icons.info_outline_rounded),
                              ),
                              Flexible(
                                child: Text(
                                  'Une vue peut être qualifiée d’exceptionnelle lorsque le bien donne sur un monument ou un élément naturel notable comme la mer, la montagne etc...',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Multi',
                                    fontSize: 13,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0,
                                    height: 1.25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                            top: 40,
                          ),
                          child: Text(
                            'Standing de votre Bien',
                            style: AppTheme.formTitleBlackBoldTextStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: standing[0],
                                groupValue: _.ajoutBienFormModel.value.standing,
                                onChanged: (v) {
                                  _.updateSelectedStanding(standing[0]);
                                }),
                            GestureDetector(
                              child: Text('Moyen'),
                              onTap: () =>
                                  _.updateSelectedStanding(standing[0]),
                            ),
                            Radio(
                                value: standing[1],
                                groupValue: _.ajoutBienFormModel.value.standing,
                                onChanged: (v) {
                                  _.updateSelectedStanding(standing[1]);
                                }),
                            GestureDetector(
                              child: Text('Standard'),
                              onTap: () =>
                                  _.updateSelectedStanding(standing[1]),
                            ),
                            Radio(
                                value: standing[2],
                                groupValue: _.ajoutBienFormModel.value.standing,
                                onChanged: (v) {
                                  _.updateSelectedStanding(standing[2]);
                                }),
                            GestureDetector(
                              child: Text('Exceptionnel'),
                              onTap: () =>
                                  _.updateSelectedStanding(standing[2]),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: Get.width - 40,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(30, 197, 1, .22),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(Icons.info_outline_rounded),
                              ),
                              Flexible(
                                child: Text(
                                  'Nous entendons par ‘Standing’, le niveau de l’habitation en matière de qualité de construction, d’équipements et de confort.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Multi',
                                    fontSize: 13,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0,
                                    height: 1.25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                            top: 40,
                          ),
                          child: Text(
                            'Votre Bien est mitoyen',
                            style: AppTheme.formTitleBlackBoldTextStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: true,
                                groupValue: _.ajoutBienFormModel.value.mitoyen,
                                onChanged: (v) {
                                  _.toggleMitoyen();
                                }),
                            GestureDetector(
                              child: Text('Oui'),
                              onTap: () {
                                if (_.ajoutBienFormModel.value.mitoyen == false)
                                  _.toggleMitoyen();
                              },
                            ),
                            Radio(
                                value: false,
                                groupValue: _.ajoutBienFormModel.value.mitoyen,
                                onChanged: (v) {
                                  _.toggleMitoyen();
                                }),
                            GestureDetector(
                              child: Text('Non'),
                              onTap: () {
                                if (_.ajoutBienFormModel.value.mitoyen == true)
                                  _.toggleMitoyen();
                              },
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                            top: 40,
                          ),
                          child: Text(
                            'Emplacement de votre Bien',
                            style: AppTheme.formTitleBlackBoldTextStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: emplacement[0],
                                groupValue:
                                    _.ajoutBienFormModel.value.emplacement,
                                onChanged: (v) {
                                  _.updateSelectedEmplacement(emplacement[0]);
                                }),
                            Text('Bruyant'),
                            Radio(
                                value: emplacement[1],
                                groupValue:
                                    _.ajoutBienFormModel.value.emplacement,
                                onChanged: (v) {
                                  _.updateSelectedEmplacement(emplacement[1]);
                                }),
                            Text('Standard'),
                            Radio(
                                value: emplacement[2],
                                groupValue:
                                    _.ajoutBienFormModel.value.emplacement,
                                onChanged: (v) {
                                  _.updateSelectedEmplacement(emplacement[2]);
                                }),
                            Text('Calme'),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: Get.width - 40,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(30, 197, 1, .22),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(Icons.info_outline_rounded),
                              ),
                              Flexible(
                                child: Text(
                                  'Bruyant : proche d’artères à circulation dense, voies ferrées, aéroport etc... Standard : proche de rues animées, commerces ou restaurants etc... Calme : retiré ou donnant sur cour, en zone résidentielle etc...',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Multi',
                                    fontSize: 13,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0,
                                    height: 1.25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (value) {},
                              ),
                              Flexible(
                                child: Text(
                                  'En soumettant ce formulaire, j’accepte que les informations saisies soient exploitées dans le cadre de la relation commerciale qui peut en découler.',
                                  style: AppTheme.homeSubTitleTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25, bottom: 40),
                          height: 50,
                          width: Get.width,
                          child: CustomButton(
                            onPressedFn: () {
                              _.ajoutBienFormModel.value.cuisine =
                                  homeFeatures['Cuisine'];
                              _.ajoutBienFormModel.value.sallon =
                                  homeFeatures['Sallon'];
                              _.ajoutBienFormModel.value.terasse =
                                  homeFeatures['Terasse'];
                              _.ajoutBienFormModel.value.balcon =
                                  homeFeatures['Balcon'];
                              _.ajoutBienFormModel.value.jardin =
                                  homeFeatures['Jardin'];
                              _.ajoutBienFormModel.value.garage =
                                  homeFeatures['Garage'];
                              _.ajoutBienFormModel.value.cave =
                                  homeFeatures['Cave'];
                              _.ajoutBienFormModel.value.piscine =
                                  homeFeatures['Piscine'];
                              _.ajoutBienFormModel.value.exportationNord =
                                  exportation['Nord'];
                              _.ajoutBienFormModel.value.exportationSud =
                                  exportation['Sud'];
                              _.ajoutBienFormModel.value.exportationEst =
                                  exportation['Est'];
                              _.ajoutBienFormModel.value.exportationOuest =
                                  exportation['Ouest'];
                              // if (_.ajoutBienFormModel.value.category ==
                              //     'Proriété')
                              //   _.ajoutBienFormModel.value.category =
                              //       'PROPRIETE';
                              // else
                              //   _.ajoutBienFormModel.value.category = _
                              //       .ajoutBienFormModel.value.category
                              //       .toUpperCase();
                              // if (_.ajoutBienFormModel.value.vue == 'Vis-à-vis')
                              //   _.ajoutBienFormModel.value.vue =
                              //       'Vis_a_vis'.toUpperCase();
                              // if (_.ajoutBienFormModel.value.vue == 'Dégagée')
                              //   _.ajoutBienFormModel.value.vue =
                              //       'degagee'.toUpperCase();
                              // if (_.ajoutBienFormModel.value.vue ==
                              //     'Exceptionnelle')
                              //   _.ajoutBienFormModel.value.vue =
                              //       'exceptionnelle'.toUpperCase();
                              // if (_.ajoutBienFormModel.value.standing !=
                              //     'Exceptionnel')
                              //   _.ajoutBienFormModel.value.standing = _
                              //       .ajoutBienFormModel.value.standing
                              //       .toUpperCase();
                              _.setSurface(
                                  double.parse(surfaceTextController.text));
                              _.setSurfaceTerrain(double.parse(
                                  surfaceTerrainTextController.text));
                              _.setSurfaceSejour(double.parse(
                                  surfaceSejourTextController.text));
                              _.setConstructionDate(
                                  constructionDateController.text);
                              _.insertBien().then((value) {
                                if (value == 1)
                                  Get.toNamed(Routes.bienOverviewPage);
                              });
                              showGeneralDialog(
                                context: context,
                                pageBuilder: (s, __, ___) => Container(
                                  child: Material(
                                    color: Color.fromRGBO(0, 96, 162, .8),
                                    child: CircularPercentIndicator(
                                      key: circularindicator,
                                      radius: 200.0,
                                      lineWidth: 20.0,
                                      percent: 1,
                                      animation: true,
                                      center: Text(
                                        " 100 %",
                                        style: TextStyle(
                                            fontFamily: 'Multi',
                                            fontSize: 30,
                                            color: Colors.white,
                                            height: 0.9,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      progressColor: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                            buttonContent: 'SOUMETTRE',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          // Container(
          //   height: double.infinity,
          //   width: double.infinity,
          //   color: Color.fromRGBO(0, 96, 162, .8),
          //   child: CircularPercentIndicator(
          //     radius: 200.0,
          //     lineWidth: 20.0,
          //     percent: .7,
          //     animation: true,
          //     center: new Text("100%"),
          //     progressColor: Colors.green,
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Container buildSwitchContainer(
    int index,
  ) {
    String title = homeFeatures.keys.elementAt(index);
    return Container(
      child: Row(
        children: [
          Switch(
            value: homeFeatures[title],
            onChanged: (v) {
              setState(() {
                homeFeatures[title] = v;
              });
            },
          ),
          GestureDetector(
            child: Text(
              title,
              style: AppTheme.titleBlackBoldTextStyle,
            ),
            onTap: () => setState(() {
              homeFeatures[title] = !homeFeatures[title];
            }),
          )
        ],
      ),
    );
  }

  Container buildSwitchExportationContainer(int index) {
    String title = exportation.keys.elementAt(index);
    return Container(
      child: Row(
        children: [
          Switch(
            value: exportation[title],
            onChanged: (v) {
              setState(() {
                exportation[title] = v;
              });
            },
          ),
          GestureDetector(
            child: Text(
              title,
              style: AppTheme.titleBlackBoldTextStyle,
            ),
            onTap: () => setState(() {
              exportation[title] = !exportation[title];
            }),
          )
        ],
      ),
    );
  }

  Widget buildCategoryTag(int index, AjoutFormController _) {
    return InkWell(
      onTap: () {
        _.updateSelectedCategory(categories[categories.keys.elementAt(index)]);
      },
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: _.ajoutBienFormModel.value.category ==
                  categories[categories.keys.elementAt(index)]
              ? Color(0xFF1EC501)
              : Color(0xffE9ECF2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 7,
          ),
          child: Text(
            categories.keys.elementAt(index),
            textAlign: TextAlign.center,
            style: AppTheme.smallBoldBlackTextStyle,
          ),
        ),
      ),
    );
  }
}
