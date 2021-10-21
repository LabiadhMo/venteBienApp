import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:oikos/core/constants/routes.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (Set<MaterialState> states) {
              if (!states.contains(MaterialState.disabled))
                return RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(40.0));
              return null; // Use the component's default.
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (!states.contains(MaterialState.disabled)) return Colors.white;
              return null; // Use the component's default.
            },
          ),
        ),
        onPressed: () {
          Get.toNamed(Routes.homePage);
        },
        icon: SvgPicture.asset(
          "assets/icons/google.svg",
        ),
        label: Text(
          "Google",
          style: TextStyle(
            color: Color(0xff2A2A43),
            height: 1.3,
            fontSize: 14,
            letterSpacing: 0.11,
          ),
        ),
      ),
    );
  }
}
