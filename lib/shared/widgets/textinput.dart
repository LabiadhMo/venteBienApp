import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType inputType;
  final bool isPassword;
  final TextEditingController widgetCustomController;
  final bool labeled;
  const CustomTextField(
      {Key key,
      this.hintText,
      this.inputType,
      this.isPassword = false,
      this.widgetCustomController,
      this.labeled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        obscureText: isPassword,
        controller: widgetCustomController,
        keyboardType: inputType != null ? inputType : TextInputType.name,
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.only(
            left: 20.0,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            gapPadding: 1.0,
            borderSide: BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
          ),
          labelText: null,
          labelStyle: const TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
