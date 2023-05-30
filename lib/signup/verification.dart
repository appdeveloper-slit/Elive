import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../allstatic/colors.dart';
import '../allstatic/dimens.dart';
import '../allstatic/static_method.dart';
import '../allstatic/strings.dart';
import '../allstatic/styles.dart';
import '../homepage/mainhomepage.dart';

class Verification extends StatefulWidget {
  final String? spage;
  final String? smobile;
  final String? sregisteruser;

  const Verification({super.key, this.spage, this.smobile, this.sregisteruser});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController otpCtrl = TextEditingController();
  late BuildContext ctx;
  bool again = false;
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
              children: [
                SizedBox(
                  height: 32,
                  child: const Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'NotoSansTaiTham',
                    ),
                  ),
                ),
                const Text(
                  "We've send you the verification ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'NotoSansTaiTham',
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Wrap(
                    // ignore: prefer_const_literals_to_create_immutables
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        'code on ',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'NotoSansTaiTham'),
                      ),
                      // ignore: prefer_const_constructors
                      Text(
                        '${widget.smobile}',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.yellow,),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 40.03, left: 18.9, right: 18.9, bottom: 30),
                  child: PinCodeTextField(
                    controller: otpCtrl,
                    appContext: ctx,
                    enableActiveFill: true,
                    textStyle: Sty().largeText.copyWith(
                          color: Clr().white,
                        ),
                    length: 4,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    animationType: AnimationType.scale,
                    cursorColor: Clr().white,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(Dim().d4),
                      fieldWidth: Dim().d60,
                      fieldHeight: Dim().d56,
                      selectedFillColor: Clr().primaryColor,
                      activeFillColor: Clr().primaryColor,
                      inactiveFillColor: Clr().primaryColor,
                      inactiveColor: Clr().primaryColor,
                      activeColor: Clr().primaryColor,
                      selectedColor: Clr().primaryColor,
                    ),
                    animationDuration: const Duration(milliseconds: 200),
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field is required";
                      }
                      if (value.length != 4) {
                        return "OTP digits must be 4";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Visibility(
                        visible: !again,
                        child: TweenAnimationBuilder<Duration>(
                            duration: const Duration(seconds: 60),
                            tween: Tween(
                                begin: const Duration(seconds: 60),
                                end: Duration.zero),
                            onEnd: () {
                              // ignore: avoid_print
                              // print('Timer ended');
                              setState(() {
                                again = true;
                              });
                            },
                            builder: (BuildContext context, Duration value,
                                Widget? child) {
                              final minutes = value.inMinutes;
                              final seconds = value.inSeconds % 60;
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Didn't get it ? ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,),
                                  ),
                                  Text(
                                    "$minutes:$seconds",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 14.0,color: Clr().golden),
                                  ),
                                ],
                              );
                            }),
                      ),
                      Visibility(
                        visible: again,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              again = false;
                            });
                            // });
                          },
                          child: Center(
                            child: Text(
                              'Resend OTP',
                              style: Sty()
                                  .mediumBoldText
                                  .copyWith(color: Clr().golden),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.spage == 'signin') {
                          verifysign();
                        } else {
                          verifyRegister();
                        }
                      }
                    },
                    child: Container(
                      height: Dim().d56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: const Color(0XFFFFC107),
                      ),
                      child: const Center(
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'NotoSansTaiTham',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void verifyRegister() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    FormData body = FormData.fromMap({
      'phone': widget.smobile,
      'page_type': 'register',
      'otp': otpCtrl.text,
      'name': widget.sregisteruser,
    });
    var result = await STM().post(ctx, Str().verifying, 'verifyotp', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM.displayToast(message);
      sp.setBool('is_login', true);
      sp.setString('user_id', result['user']['id'].toString());
      sp.setString('user_name', result['user']['name'].toString());
      sp.setString('user_mobile', result['user']['phone'].toString());
      STM.finishAffinity(ctx, MainHomePage());
    } else {
      STM.errorDialog(ctx, message);
    }
  }

  void verifysign() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    FormData body = FormData.fromMap({
      'phone': widget.smobile,
      'page_type': 'login',
      'otp': otpCtrl.text,
    });
    var result = await STM().post(ctx, Str().verifying, 'verifyotp', body);
    var success = result['success'];
    var message = result['message'];
    var error = result['error'];
    if (success) {
      STM.displayToast(message);
      sp.setBool('is_login', true);
      sp.setString('user_id', result['user']['id'].toString());
      sp.setString('user_name', result['user']['name'].toString());
      sp.setString('user_mobile', result['user']['phone'].toString());
      STM.finishAffinity(ctx, MainHomePage());
    } else {
      STM.errorDialog(ctx, message);
    }
  }
}
