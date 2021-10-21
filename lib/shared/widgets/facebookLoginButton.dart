import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FacebookLoginButton extends StatelessWidget {
  const FacebookLoginButton({
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
              if (!states.contains(MaterialState.disabled))
                return Color(0xff245A9C);
              return null; // Use the component's default.
            },
          ),
        ),
        onPressed: () {},
        icon: SvgPicture.asset('assets/icons/facebook.svg'),
        label: Text(
          "Facebook",
          style: TextStyle(
            color: Colors.white,
            height: 1.3,
            fontSize: 14,
            letterSpacing: 0.11,
          ),
        ),
      ),
    );
  }
}
