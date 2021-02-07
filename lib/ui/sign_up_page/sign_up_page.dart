import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';

import 'package:education/ui/sign_up_page/sign_up_page_model.dart';
import 'package:education/ui/sign_up_page/sign_up_page_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../registration_page_input_widget.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignInPageModel model = SignInPageModel();
  final SignUpPageServices _services = SignUpPageServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorTable.swatch1,
        body: FutureBuilder(
          future: _services.firestoreDBService.getAllUsersUsername(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  width: Constants.getWidth(context),
                  height: Constants.getHeight(context),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 35, right: 35, top: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kayıt Ol',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w900,
                              fontSize: Constants.getHeight(context) / 20),
                        ),
                        Form(
                          key: model.formKey,
                          child: Column(
                            children: [
                              InputWidget(model.fullname, context,
                                  'İsim-Soyisim', TextInputType.name,
                                  validator: _services.nameValidator),
                              InputWidget(model.username, context,
                                  'Kullanıcı adı', TextInputType.text,
                                  validator: (String value) {
                                for (var i = 0; i < snapshot.data.length; ++i) {
                                  if (snapshot.data[i]
                                          .toString()
                                          .toLowerCase() ==
                                      value.toLowerCase()) {
                                    return 'Bu kullanıcı adı zaten sistemde kayıtlı';
                                  }
                                }
                                return null;
                              }),
                              InputWidget(
                                  model.phone,
                                  context,
                                  'Telefon Numarası',
                                  TextInputType.numberWithOptions(
                                      decimal: true),
                                  validator: _services.phoneValidator),
                              InputWidget(model.email, context, 'E-posta',
                                  TextInputType.emailAddress,
                                  validator: _services.emailValidator),
                              InputWidget(model.password, context, 'Şifre',
                                  TextInputType.visiblePassword,
                                  validator: _services.passwordValidator),
                              InputWidget(
                                model.passwordAgain,
                                context,
                                'Şifre tekrar',
                                TextInputType.visiblePassword,
                                validator: (value) {
                                  return _services.repeatPasswordValidator(
                                      value, model.password.text);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Material(
                                  color: Colors.white.withOpacity(0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                                    splashColor: Colors.red,
                                    onTap: () {
                                      continueButton();
                                    },
                                    child: Container(
                                      height:
                                          Constants.getHeight(context) / 12.93,
                                      width: Constants.getWidth(context) / 1.82,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            bottomRight: Radius.circular(30)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'Kayıt Ol',
                                            style: GoogleFonts.poppins(
                                                fontSize: Constants.getHeight(
                                                        context) /
                                                    35.55,
                                                color: ColorTable.textColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.arrow_right_alt_outlined,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  // ignore: always_declare_return_types
  continueButton() {
    if (model.formKey.currentState.validate()) {
      model.formKey.currentState.save();
      _services.signUp(
          context,
          model.email.text,
          model.password.text,
          model.passwordAgain.text,
          model.fullname.text,
          model.username.text,
          model.phone.text);
    }
  }
}
