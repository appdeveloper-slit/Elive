// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:elive/allstatic/static_method.dart';
import 'package:elive/signup/signin.dart';
import 'package:elive/signup/verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../allstatic/colors.dart';
import '../allstatic/dimens.dart';
import '../allstatic/strings.dart';
import '../allstatic/styles.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController userctrl = TextEditingController();
  TextEditingController mobctrl = TextEditingController();
  late BuildContext ctx;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            height: 500,
            width: 900,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 82.19, bottom: 25, right: 81.9),
                  child: Text(
                    'Create New Account',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'NotoSansTaiTham'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dim().d14, vertical: Dim().d20),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    controller: userctrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name field is required';
                      }
                    },
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
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
                      hintText: 'Username',
                      hintStyle: Sty().mediumText.copyWith(
                            color: Clr().hint,
                            fontSize: Dim().d16,
                          ),
                      prefixIcon: Padding(
                        padding:
                            EdgeInsets.only(left: Dim().d32, right: Dim().d20),
                        child: SvgPicture.asset(
                          'assets/images/user.svg',
                          color: Color(0xff707071),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dim().d16,
                  ),
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
                        return 'Mobile Number must be of 10 digit';
                      } else {
                        return null;
                      }
                    },
                    controller: mobctrl,
                    decoration: InputDecoration(
                      isDense: true,
                      prefixIcon: Padding(
                        padding:
                            EdgeInsets.only(left: Dim().d32, right: Dim().d20),
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
                      EdgeInsets.only(left: 20.0, right: 20, top: Dim().d20),
                  child: GestureDetector(
                    onTap: () {
                     if(_formKey.currentState!.validate()){
                       setState(() {
                         SendOtp();
                       });
                     }
                    },
                    child: Container(
                      height: Dim().d56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Color(0XFFFFC107),
                      ),
                      child: Center(
                        child: Text(
                          'CREATE ACCOUNT',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'NotoSansTaiTham',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dim().d20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'Already have an account ? ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'NotoSansTaiTham'),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xffffc107),
                                fontFamily: 'NotoSansTaiTham'),
                          )),
                    ],
                  ),
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
      'phone': mobctrl.text,
      'page_type': 'register',
    });
    var result = await STM().post(ctx, Str().sendingOtp, 'sendOtp', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM.displayToast(message);
      STM.redirect2page(
        ctx,
        Verification(
          smobile: mobctrl.text,
          sregisteruser: userctrl.text,
        ),
      );
    } else {
      STM.errorDialog(ctx, message);
    }
  }
}
