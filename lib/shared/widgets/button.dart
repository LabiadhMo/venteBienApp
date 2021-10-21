import 'package:flutter/material.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final Function onPressedFn;
  final String buttonContent;

  const CustomButton({
    Key key,
    @required this.onPressedFn,
    @required this.buttonContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
          (Set<MaterialState> states) {
            if (!states.contains(MaterialState.disabled))
              return RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0));
            return null; // Use the component's default.
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (!states.contains(MaterialState.disabled)) return kButtonColor;
            return null; // Use the component's default.
          },
        ),
      ),
      onPressed: onPressedFn,
      child: Text(
        buttonContent,
        textScaleFactor: 1.0,
        style: AppTheme.buttonTextStyle,
      ),
    );
  }
}
