import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserWidget extends StatelessWidget {
  String rozet;
  String username;
  String seviye;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              height: Constants.getHeight(context) /17,
              width: Constants.getWidth(context) / 9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                    )
                  ]
              ),
              child: Image.asset(
                rozet,
                height: Constants.getHeight(context) / 17,
                width: Constants.getWidth(context) / 9,
                fit: BoxFit.fill,
              ),
          ),
          Column(
            children: [
              Text('@${username}',style: GoogleFonts.poppins(
                fontSize: Constants.getHeight(context)/45,
                fontWeight: FontWeight.w500,
                color: ColorTable.textColor
              ),),
              Text('${seviye}',style: GoogleFonts.poppins(
                  fontSize: Constants.getHeight(context)/55,
                  fontWeight: FontWeight.w500,
                  color: ColorTable.textColor.withOpacity(0.3)
              ),),
            ],
          )
        ],
      ),
    );
  }

  UserWidget({this.rozet, this.username, this.seviye});
}
