import 'package:flutter/material.dart';
import 'package:oikos/core/config/theme.dart';

/*
FormInputField(
                controller: _url,
                labelText: 'Post URL',
                validator: Validator.notEmpty,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                onChanged: (value) => print('changed'),
                onSaved: (value) => print('implement me'),
              ),
*/

// ignore: must_be_immutable
class FormInputField extends StatelessWidget {
  final Widget suffixIcon;
  bool showPassword;
  FormInputField(
      {this.controller,
      this.labelText,
      this.validator,
      this.showPassword = false,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.onChanged,
      this.onSaved,
      this.suffixIcon});

  final TextEditingController controller;
  final String labelText;
  final String Function(String) validator;
  final TextInputType keyboardType;
  bool obscureText;
  final int minLines;
  final void Function(String) onChanged;
  final void Function(String) onSaved;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        padding: EdgeInsets.all(0),
        textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),
      ),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          // obscureText
          //     ? IconButton(
          //         icon: Icon(Icons.visibility_outlined),
          //         onPressed: () {
          //           print('pressed');
          //         },
          //       )
          //     : null,
          errorStyle: TextStyle(color: Colors.red),

          errorBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: BorderSide(color: Colors.red, width: 0.5)),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.only(left: 20.0, bottom: 0),

          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            gapPadding: 0.0,
            borderSide: BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          hintText: labelText,
          hintStyle: AppTheme.hintTextStyle,
          labelText: null,
          labelStyle: const TextStyle(
            fontFamily: 'Multi',
            color: Colors.black,
          ),
        ),
        controller: controller,
        onSaved: onSaved,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: obscureText ? 1 : null,
        minLines: minLines,
        validator: validator,
      ),
    );
  }
}
