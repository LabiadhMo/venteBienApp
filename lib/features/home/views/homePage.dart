import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/features/auth/controllers/authController.dart';
import 'package:oikos/features/auth/data/models/userProfile.dart';
import 'package:oikos/features/auth/utils/authenticationstatus.dart';
import 'package:oikos/shared/widgets/bottomNavBar.dart';

class HomePage extends StatefulWidget {
  @override
  _MenuDashBoardState createState() => _MenuDashBoardState();
}

class _MenuDashBoardState extends State<HomePage> {
  bool isMenuClosed = true;
  double screenWidth;
  int selectedScreen = 0;
  GlobalKey greenIndicatorKey = GlobalKey();
  double top, left, width;
  UserProfile userProfile;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    userProfile = (Get.find<AuthController>().state as Authenticated).user;
  }

  _afterLayout(_) {
    setState(() {
      _getPosition();
    });
  }

  _getPosition() async {
    final RenderBox rb = greenIndicatorKey.currentContext.findRenderObject();
    var position = rb.localToGlobal(Offset.zero);
    top = position.dy;
    left = position.dx;
    width = rb.size.width;
    print('$left , $top');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            menu(context),
            dashboard(context),
          ],
        ),
      ),
      bottomNavigationBar: isMenuClosed
          ? CustomBottomNavBar(
              index: 0,
            )
          : null,
    );
  }

  Widget menu(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[AppTheme.kAppBarGradient1, AppTheme.kAppBarGradient2],
        ),
      ),
      padding: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.15, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 25, left: 36),
              height: 110,
              color: AppTheme.kAppBarGradient2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset('assets/icons/google.svg'),
                ),
                title: Text(
                  userProfile.firstName + ' ' + userProfile.lastName,
                  textScaleFactor: 1.0,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  userProfile.departmentName,
                  textScaleFactor: 1.0,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 25,
                left: 35,
              ),
              height: 45,
              width: 185,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Switch(
                    value: true,
                    onChanged: (v) {
                      print("mm");
                    },
                  ),
                  Text(
                    'Mode Propriétaire',
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
                bottom: 0,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/dashbord.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "TABLEAU DE BORD",
                      textScaleFactor: 1.0,
                      style: AppTheme.drawerTextStyle,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/messageries.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "MESSAGERIES",
                      textScaleFactor: 1.0,
                      style: AppTheme.drawerTextStyle,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/stats.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "STATISTIQUE & HISTORIQUE",
                      style: AppTheme.drawerTextStyle,
                      textScaleFactor: 1.0,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/biens.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "MES BIENS",
                      style: AppTheme.drawerTextStyle,
                      textScaleFactor: 1.0,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/services.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "SERVICES",
                      style: AppTheme.drawerTextStyle,
                      textScaleFactor: 1.0,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/visites.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "VISITES",
                      style: AppTheme.drawerTextStyle,
                      textScaleFactor: 1.0,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/parametres.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "PARAMETRES",
                      style: AppTheme.drawerTextStyle,
                      textScaleFactor: 1.0,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/assistance.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "ASSISTANCE",
                      style: AppTheme.drawerTextStyle,
                      textScaleFactor: 1.0,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 25,
              ),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/recherche.svg'),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "RECHERCHE",
                      style: AppTheme.drawerTextStyle,
                      textScaleFactor: 1.0,
                    ),
                  )),
            ),
            Container(
              width: 280,
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 140,
                bottom: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('assets/icons/facebook.svg'),
                  SvgPicture.asset('assets/icons/instagram.svg'),
                  SvgPicture.asset('assets/icons/twitter.svg'),
                  Text(
                    "Oikos © 2021",
                    textScaleFactor: 1.0,
                    style: AppTheme.smallTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      //top: isMenuClosed? 0 : 100,
      //bottom: isMenuClosed? 0 : 100,
      top: 0,
      bottom: 0,
      left: isMenuClosed ? 0 : 280,
      right: isMenuClosed ? 0 : -280,
      duration: Duration(milliseconds: 300),
      child: Material(
        elevation: 8,
        color: Colors.white,
        child: Column(
          children: [
            builtHomeScreenAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 40),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 115,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 8,
                                      color: Color.fromRGBO(0, 0, 0, 0.09),
                                      offset: Offset(0, 2),
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/biens.svg',
                                    height: 34,
                                    width: 34,
                                    color: AppTheme.kAppBarGradient2,
                                  ),
                                  Text(
                                    'MES BIENS',
                                    textScaleFactor: 1.0,
                                    style: AppTheme.homeSubTitleTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 115,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 8,
                                      color: Color.fromRGBO(0, 0, 0, 0.09),
                                      offset: Offset(0, 2),
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/services.svg',
                                    height: 34,
                                    width: 34,
                                    color: AppTheme.kAppBarGradient2,
                                  ),
                                  Text(
                                    'SERVICES',
                                    textScaleFactor: 1.0,
                                    style: AppTheme.homeSubTitleTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 1,
                            child: Stack(
                              children: [
                                Container(
                                  key: greenIndicatorKey,
                                  height: 115,
                                  width: 155,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 8,
                                          color: Color.fromRGBO(0, 0, 0, 0.09),
                                          offset: Offset(0, 2),
                                        )
                                      ]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/messageries.svg',
                                        height: 34,
                                        width: 34,
                                        color: AppTheme.kAppBarGradient2,
                                      ),
                                      Text(
                                        'MESSAGERIES',
                                        textScaleFactor: 1.0,
                                        style: AppTheme.homeSubTitleTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                                if (isMenuClosed)
                                  Positioned(
                                    child: Container(
                                      height: 17,
                                      width: 17,
                                      decoration: BoxDecoration(
                                        color: AppTheme.kprimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    right: 0,
                                    top: 0,
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25,
                        top: 35,
                      ),
                      child: Divider(
                        color: Color(0xffE8E8E8),
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 35,
                      ),
                      height: 65,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(241, 241, 241, 0.44),
                        border: Border.all(
                          color: Color(0xffE9E9E9),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textScaleFactor: 1.0,
                            text: TextSpan(
                              text: 'Vous avez ',
                              style: TextStyle(
                                color: Color.fromRGBO(126, 126, 126, 1),
                                fontSize: 12,
                                height: 1.25,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Multi',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '2 nouveaux offres',
                                  style: TextStyle(
                                    color: Color.fromRGBO(126, 126, 126, 1),
                                    fontSize: 12,
                                    height: 1.25,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Multi',
                                  ),
                                ),
                                TextSpan(
                                  text: ' non lus.',
                                  style: TextStyle(
                                    color: Color.fromRGBO(126, 126, 126, 1),
                                    fontSize: 12,
                                    height: 1.25,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Multi',
                                  ),
                                )
                              ],
                            ),
                          ),
                          SvgPicture.asset('assets/icons/label.svg')
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 15,
                      ),
                      height: 65,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(241, 241, 241, 0.44),
                        border: Border.all(
                          color: Color(0xffE9E9E9),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textScaleFactor: 1.0,
                            text: TextSpan(
                              text: 'Vous avez ',
                              style: TextStyle(
                                color: Color.fromRGBO(126, 126, 126, 1),
                                fontSize: 12,
                                height: 1.25,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Multi',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '1 bien en approbation.',
                                  style: TextStyle(
                                    color: Color.fromRGBO(126, 126, 126, 1),
                                    fontSize: 12,
                                    height: 1.25,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Multi',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset('assets/icons/label.svg')
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 15,
                      ),
                      height: 65,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(241, 241, 241, 0.44),
                        border: Border.all(
                          color: Color(0xffE9E9E9),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textScaleFactor: 1.0,
                            text: TextSpan(
                              text: 'Vous avez ',
                              style: TextStyle(
                                color: Color.fromRGBO(126, 126, 126, 1),
                                fontSize: 12,
                                height: 1.25,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Multi',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '3 CR de visites',
                                  style: TextStyle(
                                    color: Color.fromRGBO(126, 126, 126, 1),
                                    fontSize: 12,
                                    height: 1.25,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Multi',
                                  ),
                                ),
                                TextSpan(
                                  text: ' non lus.',
                                  style: TextStyle(
                                    color: Color.fromRGBO(126, 126, 126, 1),
                                    fontSize: 12,
                                    height: 1.25,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Multi',
                                  ),
                                )
                              ],
                            ),
                          ),
                          SvgPicture.asset('assets/icons/label.svg')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25,
                        top: 35,
                      ),
                      child: Divider(
                        color: Color(0xffE8E8E8),
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 30,
                        bottom: 25,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Prochain RDV',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Multi',
                                  fontWeight: FontWeight.w800,
                                  height: 1,
                                ),
                              ),
                              Text(
                                'Nombre Totale d\'Offres Reçus',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Multi',
                                  fontWeight: FontWeight.w800,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '25/2/2021 à 10:00',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  color: Color.fromRGBO(143, 155, 179, 1),
                                  fontSize: 12,
                                  fontFamily: 'Multi',
                                  fontWeight: FontWeight.w800,
                                  height: 1,
                                ),
                              ),
                              Text(
                                '51',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  color: Color.fromRGBO(143, 155, 179, 1),
                                  fontSize: 12,
                                  fontFamily: 'Multi',
                                  fontWeight: FontWeight.w800,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        bottom: 10,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Revenue en Février',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Multi',
                                  fontWeight: FontWeight.w800,
                                  height: 1,
                                ),
                              ),
                              Text(
                                'Nombre des Biens Actifs',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Multi',
                                  fontWeight: FontWeight.w800,
                                  height: 1,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '1,536 €',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  color: Color.fromRGBO(143, 155, 179, 1),
                                  fontSize: 12,
                                  fontFamily: 'Multi',
                                  fontWeight: FontWeight.w800,
                                  height: 1,
                                ),
                              ),
                              Text(
                                '10',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  color: Color.fromRGBO(143, 155, 179, 1),
                                  fontSize: 12,
                                  fontFamily: 'Multi',
                                  fontWeight: FontWeight.w800,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container builtHomeScreenAppBar() {
    return Container(
      padding: EdgeInsets.only(
        top: 30,
      ),
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[AppTheme.kAppBarGradient1, AppTheme.kAppBarGradient2],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: isMenuClosed ? 20 : 15,
              bottom: isMenuClosed ? 15 : 7,
            ),
            child: IconButton(
              icon: Icon(
                isMenuClosed ? Icons.menu : Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isMenuClosed = !isMenuClosed;
                });
              },
            ),
          ),
          if (isMenuClosed)
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                "TABLEAU DE BORD",
                style: AppTheme.appBarTitleTextStyle,
                textScaleFactor: 1.0,
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 15),
            child: IconButton(
              onPressed: () {
                Get.find<AuthController>().signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
                size: 24,
              ),
            ),
          )
        ],
      ),
    );
  }
}
