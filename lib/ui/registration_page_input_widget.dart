import 'package:education/app/constants.dart';
import 'package:flutter/material.dart';

Widget InputWidget(TextEditingController controller, BuildContext context,
    String string, TextInputType textInputType,
    {Function validator, suffixIcon}) {
  return Padding(
    padding: const EdgeInsets.only(top: 18.0),
    child: Container(
      height: Constants.getHeight(context) / 12.93,
      decoration: BoxDecoration(
          color: Color(0xff98ded9).withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Center(
        child: TextFormField(
          obscureText:
              (string == 'Şifre') || (string == 'Şifre tekrar') ? true : false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          keyboardType: textInputType,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: string,
            contentPadding: EdgeInsets.only(left: 8),
          ),
          autofocus: false,
        ),
      ),
    ),
  );
}
