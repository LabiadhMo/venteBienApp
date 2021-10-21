import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/shared/widgets/bottomNavBar.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        index: 1,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 30,
            ),
            height: 80,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    bottom: 15,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "NOTIFICATIONS",
                    textScaleFactor: 1.0,
                    style: AppTheme.appBarTitleTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 15),
                  child: SvgPicture.asset(
                    'assets/icons/notification.svg',
                    color: Colors.white,
                    height: 24,
                    width: 24,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 45.0, left: 20),
                    child: Text(
                      'Aujourd\'hui 30-03-2021',
                      textScaleFactor: 1.0,
                      style: AppTheme.titleBlackBoldTextStyle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 10,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
