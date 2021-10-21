import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/core/constants/routes.dart';
import 'package:oikos/features/auth/controllers/authController.dart';
import 'package:oikos/features/mesBien/controllers/mesBienController.dart';
import 'package:oikos/features/mesBien/data/providers/bienDetailsEndPoint.dart';
import 'package:oikos/features/mesBien/data/providers/mesBienEndPoints.dart';
import 'package:oikos/shared/widgets/bottomNavBar.dart';
import 'package:oikos/shared/widgets/button.dart';

class MesBiensScreen extends StatelessWidget {
  MesBienEndPoint mesBienEndPoint = MesBienEndPoint();
  AuthController authController = Get.find();

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
            'Mes Biens'.toUpperCase(),
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
      bottomNavigationBar: CustomBottomNavBar(
        index: 3,
      ),
      body: FutureBuilder(
          future: mesBienEndPoint.fetchAllProperties(authController.token),
          builder: (i, snapshot) {
            if (!snapshot.hasData)
              return CircularProgressIndicator();
            else
              return GetBuilder<MesBienController>(
                  init: Get.find(),
                  builder: (_) {
                    return ListView.builder(
                        padding: EdgeInsets.all(25),
                        itemCount: snapshot.data.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0)
                            return Container(
                              margin: EdgeInsets.only(bottom: 20),
                              height: 50,
                              width: Get.width,
                              child: CustomButton(
                                buttonContent: 'Ajouter un bien',
                                onPressedFn: () {
                                  Get.toNamed(Routes.ajoutBienPage,
                                      arguments: true);
                                },
                              ),
                            );
                          DateTime date =
                              DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
                                  .parse(snapshot.data[index - 1]['createdAt']);
                          //  mesBienEndPoint.bienDelete(
                          //    snapshot.data[index-1]['id'], authController.token);

                          return Container(
                            height: _.selectedBien == index - 1 ? 230 : 165,
                            width: Get.width,
                            margin: EdgeInsets.only(bottom: 10),
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
                                InkWell(
                                  onTap: () {
                                    _.updateSelected(index - 1);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child:
                                            Image.asset('assets/images/h.png'),
                                        height: 110,
                                        width: 160,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data[index - 1]
                                                      ['address']['city'] +
                                                  '-' +
                                                  snapshot.data[index - 1]
                                                      ['address']['stateFull'],
                                              style: AppTheme
                                                  .formTitleBlackBoldTextStyle,
                                            ),
                                            Text(
                                              '${snapshot.data[index - 1]['nbRooms']} pièces - ${snapshot.data[index - 1]['allArea']} m2',
                                              style: TextStyle(
                                                fontFamily: 'Multi',
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal,
                                                height: 1.35,
                                                color: Color.fromRGBO(
                                                    155, 155, 155, 1),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data[index - 1]['price']
                                                      .toString() +
                                                  ' €',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal,
                                                height: 1.35,
                                                color: Color.fromRGBO(
                                                    155, 155, 155, 1),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 17,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/calendar.svg',
                                                    color: Color.fromRGBO(
                                                        38, 153, 251, 1),
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
                                                    color: Color.fromRGBO(
                                                        38, 153, 251, 1),
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
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/horloge.svg',
                                                    color: Color.fromRGBO(
                                                        38, 153, 251, 1),
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                ),
                                                Text(
                                                  date.hour.toString() +
                                                      ':' +
                                                      date.minute.toString(),
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        38, 153, 251, 1),
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
                                ),
                                if (_.selectedBien == index - 1)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.visibility_outlined,
                                          size: 25,
                                          color: AppTheme.kAppBarGradient2,
                                        ),
                                        onPressed: () {
                                          Get.toNamed(Routes.BienDetails,
                                              arguments: snapshot
                                                  .data[index - 1]['id']);
                                        },
                                      ),
                                      Container(
                                        width: 220,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Color(0xffEEEEEE),
                                            border: Border.all(
                                                color: Color(0xffE5E5E5),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              Icons.assistant_photo_outlined,
                                              color: AppTheme.kAppBarGradient2,
                                            ),
                                            Text(
                                              'ASSISTANT DE CREATION D\'ANNONCES'
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color:
                                                    AppTheme.kAppBarGradient2,
                                                fontFamily: "Multi",
                                                fontSize: 8,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                                height: 1.2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          icon: SvgPicture.asset(
                                            'assets/icons/edit.svg',
                                            color: AppTheme.kAppBarGradient1,
                                          ),
                                          onPressed: () {
                                            Get.toNamed(Routes.ajoutBienPage,
                                                arguments: snapshot
                                                    .data[index - 1]['id']);
                                          })
                                    ],
                                  )
                              ],
                            ),
                          );
                        });
                  });
          }),
    );
  }
}
