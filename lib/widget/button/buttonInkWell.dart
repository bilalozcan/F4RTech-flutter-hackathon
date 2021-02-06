import 'file:///D:/Projects/F4RTech-flutter-hackathon/lib/app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonInkWell extends StatelessWidget {
  String test;
  Function function;
  ButtonInkWell(this.function,this.test);
  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        splashColor: Colors.red,
        onTap: () {
          function();
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 12.93,
          width: MediaQuery.of(context).size.width / 1.82,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                test,
                style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height / 35.55,
                    color: ColorTable.textColor,
                    fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.arrow_right_alt_outlined,
                size: MediaQuery.of(context).size.height / 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
