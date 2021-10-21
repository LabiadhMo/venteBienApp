import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/core/constants/routes.dart';
import 'package:oikos/features/mesBien/controllers/ajoutFormController.dart';
import 'package:oikos/shared/widgets/button.dart';

class AjouterDescription extends StatefulWidget {
  @override
  _AjouterDescriptionState createState() => _AjouterDescriptionState();
}

class _AjouterDescriptionState extends State<AjouterDescription> {
  AjoutFormController ajoutFormController = Get.find();

  TextEditingController descriptionEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    descriptionEditingController.text =
        ajoutFormController.ajoutBienFormModel.value.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      '10 rue AlbertMat - Virigneux 42140',
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(top: 50, left: 25, right: 25),
                      child: Text(
                        'Proposer un texte d\'annonce',
                        style: AppTheme.formTitleBlackBoldTextStyle,
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        padding: EdgeInsets.all(0),
                        textScaleFactor: MediaQuery.of(context)
                            .textScaleFactor
                            .clamp(1.0, 1.0),
                      ),
                      child: TextField(
                        controller: descriptionEditingController,
                        keyboardType: TextInputType.text,
                        scrollPhysics: ScrollPhysics(),
                        decoration: InputDecoration(
                          fillColor: Color(0XffF7F7F7),
                          filled: true,
                          contentPadding: const EdgeInsets.all(20.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            gapPadding: 1,
                            borderSide: const BorderSide(
                              color: Color(0xffEEEEEE),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            gapPadding: 1.0,
                            borderSide: BorderSide(
                              color: Color(0xffEEEEEE),
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            gapPadding: 1,
                            borderSide: BorderSide(
                              color: Color(0xffEEEEEE),
                              width: 1,
                            ),
                          ),
                          hintText:
                              'La maison est située dans un endroit calme avec vue dégagée sur la vallée. Au rez-de-chaussée vous profiterez : \n – Un séjour très lumineux de 40m2 donnant sur une terrasse.\n – Un coin cuisine très bien aménagé et équipé.',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Multi',
                            color: Color(0xff848484),
                          ),
                          labelText: null,
                          labelStyle: const TextStyle(
                            fontFamily: 'Multi',
                            color: Colors.black,
                          ),
                        ),
                        maxLines: 15,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 45, right: 45, top: 45),
                    height: 50,
                    width: double.infinity,
                    child: CustomButton(
                      buttonContent: 'Valider le bien'.toUpperCase(),
                      onPressedFn: () async {
                        bool b = await ajoutFormController.insertDescription(
                            descriptionEditingController.text);
                        if (b)
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
                                          'La secrétaire affiliée va vous contacter en vous donnant le choix de fixer une date et heure d\'appel.',
                                          style: AppTheme
                                              .formTitleBlackBoldTextStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          child: TextButton(
                                            onPressed: () {
                                              Get.offNamedUntil(
                                                  Routes.BienDetails,
                                                  ModalRoute.withName(
                                                      ajoutFormController
                                                                  .isAddNew ==
                                                              true
                                                          ? Routes.monComptePage
                                                          : Routes
                                                              .mesBiensPage),
                                                  arguments: ajoutFormController
                                                      .ajoutBienFormModel
                                                      .value
                                                      .id);
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
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
