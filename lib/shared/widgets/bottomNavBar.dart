import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:oikos/core/constants/routes.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int index;

  const CustomBottomNavBar({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Color(0xFF0060A2),

          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.red,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: new TextStyle(
                  color: Colors
                      .yellow))), // sets the inactive color of the `BottomNavigationBar`
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 4,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value) {
          if (value == 0)
            Get.toNamed(Routes.homePage);
          else if (value == 1)
            Get.toNamed(Routes.notificationPage);
          else if (value == 2)
            Get.toNamed(Routes.messageriesPage);
          else if (value == 3)
            Get.toNamed(Routes.mesBiensPage);
          else if (value == 4) Get.toNamed(Routes.monComptePage);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              color: index == 0 ? Colors.white : Colors.white.withOpacity(0.3),
            ),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/notification.svg',
              color: index == 1 ? Colors.white : Colors.white.withOpacity(0.3),
            ),
            label: "notification",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/messageries.svg',
              color: index == 2 ? Colors.white : Colors.white.withOpacity(0.3),
            ),
            label: "messageries",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/biens.svg',
              color: index == 3 ? Colors.white : Colors.white.withOpacity(0.3),
            ),
            label: "mesBiens",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              color: index == 4 ? Colors.white : Colors.white.withOpacity(0.3),
            ),
            label: "monCompte",
          ),
        ],
      ),
    );
  }
}
