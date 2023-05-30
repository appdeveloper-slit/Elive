import 'package:dio/dio.dart';
import 'package:elive/allstatic/colors.dart';
import 'package:elive/allstatic/dimens.dart';
import 'package:elive/allstatic/styles.dart';
import 'package:elive/signup/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../allstatic/static_method.dart';
import '../allstatic/strings.dart';
import 'verification.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late BuildContext ctx;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController mobCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(
              Dim().pp,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Dim().d100,
                ),
                SizedBox(
                    height: 32,
                    child: Text(
                      'Welcome Back!',
                      style: Sty().mediumBoldText.copyWith(
                            color: Clr().white,
                            fontSize: Dim().d20,
                          ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      'Sign In to continue',
                      style: Sty().mediumText.copyWith(
                            color: Clr().white,
                            fontSize: Dim().d16,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: Dim().d32),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Mobile field required';
                      }
                      if (value.length != 10) {
                        return 'Mobile number must be of 10 digit';
                      } else {
                        return null;
                      }
                    },
                    controller: mobCtrl,
                    decoration: InputDecoration(
                      isDense: true,
                      prefixIcon: Padding(
                        padding:
                            EdgeInsets.only(left: Dim().d40, right: Dim().d16),
                        child: SvgPicture.asset(
                          'assets/images/call.svg',
                          color: Color(0xff707071),
                          alignment: Alignment.center,
                          height: Dim().d20,
                        ),
                      ),
                      filled: true,
                      fillColor: Clr().primaryColor,
                      enabledBorder: Sty().textFieldOutlineStyle.enabledBorder,
                      focusedBorder: Sty().textFieldOutlineStyle.focusedBorder,
                      disabledBorder:
                          Sty().textFieldOutlineStyle.disabledBorder,
                      focusedErrorBorder:
                          Sty().textFieldOutlineStyle.focusedErrorBorder,
                      errorBorder: Sty().textFieldOutlineStyle.errorBorder,
                      border: InputBorder.none,
                      hintText: 'Enter your number',
                      hintStyle: Sty().mediumText.copyWith(
                            color: Clr().hint,
                            fontWeight: FontWeight.w400,
                            fontSize: Dim().d16,
                          ),
                      counterText: "",
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20.4, left: 5, right: 5),
                  child: GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          SendOtp();
                        });
                      }
                    },
                    child: Container(
                      height: Dim().d56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Color(0xffffc107),
                      ),
                      child: Center(
                        child: Text(
                          'SIGN IN',
                          style: Sty().mediumText.copyWith(
                                color: Clr().white,
                                fontSize: Dim().d16,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "Don't have an Account ?",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'NotoSansTaiTham'),
                    ),
                    InkWell(
                      onTap: () {
                        STM.redirect2page(context, CreateAccount());
                      },
                      child: Text(
                        ' Sign Up',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xffffc107),
                            fontFamily: 'NotoSansTaiTham'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void SendOtp() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    FormData body = FormData.fromMap({
      'phone': mobCtrl.text,
      'page_type': 'login',
    });
    var result = await STM().post(ctx, Str().sendingOtp, 'sendOtp', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM.displayToast(message);
      STM.redirect2page(
        ctx,
        Verification(
          spage: 'signin',
          smobile: mobCtrl.text,
        ),
      );
    } else {
      STM.errorDialog(ctx, message);
    }
  }
}
