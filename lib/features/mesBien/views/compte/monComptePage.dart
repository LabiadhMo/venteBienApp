import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/core/constants/api.dart';
import 'package:oikos/core/constants/colors.dart';
import 'package:oikos/core/constants/routes.dart';
import 'package:oikos/features/auth/controllers/authController.dart';
import 'package:oikos/features/auth/data/models/userProfile.dart';
import 'package:oikos/features/auth/utils/authenticationstatus.dart';
import 'package:oikos/features/mesBien/controllers/monCompteController.dart';
import 'package:oikos/features/mesBien/data/providers/mesBienEndPoints.dart';
import 'package:oikos/shared/widgets/backgroundWidget.dart';
import 'package:oikos/shared/widgets/bottomNavBar.dart';
import 'package:image_picker/image_picker.dart';

class MonCompteScreen extends StatefulWidget {
  @override
  _MonCompteScreenState createState() => _MonCompteScreenState();
}

class _MonCompteScreenState extends State<MonCompteScreen> {
  MesBienEndPoint _mesBienEndPoint = MesBienEndPoint();
  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        MonCompteController monCompteController = Get.find();
        monCompteController.insertPhoto(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  AuthController _authController = Get.find();
  UserProfile userProfile;
  @override
  Widget build(BuildContext context) {
    userProfile = (Get.find<AuthController>().state as Authenticated).user;

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
            'Mon Compte',
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
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        index: 4,
      ),
      body: FutureBuilder(
          future: _mesBienEndPoint.fetchAllProperties(_authController.token),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return CircularProgressIndicator();
            else if (snapshot.data.length > 0) {
              DateTime date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
                  .parse(snapshot.data[0]['createdAt']);
              return Column(
                children: [
                  buildProfile(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mes biens',
                          style: AppTheme.formTitleBlackBoldTextStyle,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.mesBiensPage);
                            },
                            child: Text(
                              'Voir tous',
                              style: AppTheme.hintTextStyle,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 165,
                    width: Get.width,
                    margin: EdgeInsets.only(
                        bottom: 10, left: 25, right: 25, top: 5),
                    padding: EdgeInsets.all(15),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Image.asset('assets/images/h.png'),
                              height: 110,
                              width: 160,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[0]['address']['city'] +
                                        '-' +
                                        snapshot.data[0]['address']
                                            ['stateFull'],
                                    style: AppTheme.formTitleBlackBoldTextStyle,
                                  ),
                                  Text(
                                    '${snapshot.data[0]['nbRooms']} pièces - ${snapshot.data[0]['allArea']} m2',
                                    style: TextStyle(
                                      fontFamily: 'Multi',
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      height: 1.35,
                                      color: Color.fromRGBO(155, 155, 155, 1),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data[0]['price'].toString() + ' €',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      height: 1.35,
                                      color: Color.fromRGBO(155, 155, 155, 1),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 17,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: SvgPicture.asset(
                                          'assets/icons/calendar.svg',
                                          color:
                                              Color.fromRGBO(38, 153, 251, 1),
                                          height: 15,
                                          width: 15,
                                        ),
                                      ),
                                      Text(
                                        date.day.toString() +
                                            '-' +
                                            date.month.toString() +
                                            '-' +
                                            date.year.toString(),
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(38, 153, 251, 1),
                                          fontFamily: "Roboto",
                                          fontSize: 11,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: SvgPicture.asset(
                                          'assets/icons/horloge.svg',
                                          color:
                                              Color.fromRGBO(38, 153, 251, 1),
                                          height: 15,
                                          width: 15,
                                        ),
                                      ),
                                      Text(
                                        date.hour.toString() +
                                            ':' +
                                            date.minute.toString(),
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(38, 153, 251, 1),
                                          fontFamily: "Roboto",
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else
              return BackgroundWidget(
                child: Column(
                  children: [
                    Align(alignment: Alignment.center, child: buildProfile()),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text(
                            'Découvrez avec OIKOS la valeur de mon bien afin de préparer au mieux mon futur projet immobilier',
                            style: AppTheme.whiteH6TextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          height: 145,
                          width: Get.width - 80,
                          margin: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 40.0,
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.resolveWith<
                                  RoundedRectangleBorder>(
                                (Set<MaterialState> states) {
                                  if (!states.contains(MaterialState.disabled))
                                    return RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0));
                                  return null; // Use the component's default.
                                },
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (!states.contains(MaterialState.disabled))
                                    return kButtonColor;
                                  return null; // Use the component's default.
                                },
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 15),
                                  child: SvgPicture.asset(
                                      'assets/icons/estimer.svg'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text('estimer mon bien'.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Multi",
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.98,
                                        height: 0.9,
                                      )),
                                )
                              ],
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.ajoutBienPage,
                                  arguments: true);
                            },
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              );
          }),
    );
  }

  buildProfile() {
    return Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(250, 50),
            bottomRight: Radius.elliptical(250, 50),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              AppTheme.kAppBarGradient1,
              AppTheme.kAppBarGradient2
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 110,
              width: 110,
              margin: EdgeInsets.only(right: 5, top: 5),
              child: Stack(
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        API.SERVER_BASE_URL + '/user/me/picture',
                        headers: {
                          'Authorization': 'Bearer ' + _authController.token
                        },
                      ),
                    ),
                  ),
                  Positioned(
                      left: 0,
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          print('Camera tapp');
                          getImage();
                        },
                        child: Container(
                          height: 33,
                          width: 33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xffC9DFEC),
                          ),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: Color(0xff0060A2),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userProfile.firstName + ' ' + userProfile.lastName,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'Multi',
                    fontWeight: FontWeight.bold,
                    height: 1.35,
                    letterSpacing: 1.05,
                  ),
                ),
                Text(
                  userProfile.departmentName,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Multi',
                    fontWeight: FontWeight.normal,
                    height: 2,
                    letterSpacing: .75,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
