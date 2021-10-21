import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/splashBackground.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
          height: Get.size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp,
              stops: [0.2, 0.7, 1],
              colors: [
                Color(0xFF1EC501).withOpacity(0.3),
                Color(0xFF31576D).withOpacity(.8),
                Color(0xFF002E63).withOpacity(.8),
              ],
            ),
          ),
          child: child),
    );
  }
}
