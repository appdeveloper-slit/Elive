import 'package:dio/dio.dart';
import 'package:elive/homepage/servicespage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../allstatic/bottom_navigation.dart';
import '../allstatic/colors.dart';
import '../allstatic/dimens.dart';
import '../allstatic/static_method.dart';
import '../allstatic/strings.dart';
import '../allstatic/styles.dart';
import 'mainhomepage.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  late BuildContext ctx;
  String? sUserid;
  String? sMobile;
  String? sUsername;
  TextEditingController userctrl = TextEditingController();
  TextEditingController mobctrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController updateUserMobileNumberController =
      TextEditingController();
  TextEditingController updateUserOtpController = TextEditingController();
  bool again = false;
  bool otpsend = false;

  getSessionData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (!mounted) return;

    setState(() {
      sUserid = sp.getString("user_id") ?? "";
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getuserProfile();
      }
    });
  }

  @override
  void initState() {
    getSessionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return WillPopScope(
      onWillPop: () async {
        STM.back2Previous(ctx);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: bottomBarLayout(ctx, 2),
        appBar: AppBar(
          backgroundColor: const Color(0xff333741),
          leading: GestureDetector(
            onTap: () {
              STM.back2Previous(ctx);
            },
            // ignore: prefer_const_constructors
            child: Icon(
              Icons.arrow_back_ios,
              color: const Color(0xffffc107),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Profile',
            style: const TextStyle(
                fontSize: 18,
                color: Color(0xffFFC107),
                fontFamily: 'NotoSansTaiTham',
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: 25, top: 25, left: Dim().d24, right: Dim().d24),
              child: TextFormField(
                cursorColor: Colors.white,
                controller: userctrl,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field is Reduired';
                  }
                },
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Clr().primaryColor,
                  enabledBorder: Sty().textFieldOutlineStyle.enabledBorder,
                  focusedBorder: Sty().textFieldOutlineStyle.focusedBorder,
                  disabledBorder: Sty().textFieldOutlineStyle.disabledBorder,
                  focusedErrorBorder:
                      Sty().textFieldOutlineStyle.focusedErrorBorder,
                  errorBorder: Sty().textFieldOutlineStyle.errorBorder,
                  border: InputBorder.none,
                  hintText: 'Enter The Username',
                  hintStyle: Sty().mediumText.copyWith(
                        color: Clr().white,
                        fontSize: Dim().d16,
                      ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: Dim().d32, right: Dim().d20),
                    child: SvgPicture.asset(
                      'assets/images/user.svg',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 25, left: Dim().d24, right: Dim().d24),
              child: TextFormField(
                readOnly: true,
                keyboardType: TextInputType.number,
                maxLength: 10,
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field is required';
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
                          EdgeInsets.only(left: Dim().d36, right: Dim().d16),
                      child: SvgPicture.asset(
                        'assets/images/call.svg',
                        color: Clr().white,
                        alignment: Alignment.center,
                        height: Dim().d20,
                      ),
                    ),
                    filled: true,
                    fillColor: Clr().primaryColor,
                    enabledBorder: Sty().textFieldOutlineStyle.enabledBorder,
                    focusedBorder: Sty().textFieldOutlineStyle.focusedBorder,
                    disabledBorder: Sty().textFieldOutlineStyle.disabledBorder,
                    focusedErrorBorder:
                        Sty().textFieldOutlineStyle.focusedErrorBorder,
                    errorBorder: Sty().textFieldOutlineStyle.errorBorder,
                    border: InputBorder.none,
                    hintText: 'Enter The Mobile',
                    hintStyle: Sty().mediumText.copyWith(
                          color: Clr().white,
                          fontWeight: FontWeight.w400,
                          fontSize: Dim().d16,
                        ),
                    counterText: "",
                    suffixIcon: InkWell(
                        onTap: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) => AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    title: Text("Change Mobile Number",
                                        style: Sty()
                                            .mediumBoldText
                                            .copyWith(color: Clr().golden)),
                                    content: SizedBox(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Visibility(
                                                  visible: !otpsend,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      const Text(
                                                        "New Mobile Number",
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Form(
                                                        key: _formKey,
                                                        child: TextFormField(
                                                          controller:
                                                              updateUserMobileNumberController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Mobile filed is required';
                                                            } else {
                                                              if (value
                                                                      .length !=
                                                                  10) {
                                                                return 'Mobile number should be 10';
                                                              }
                                                            }
                                                          },
                                                          maxLength: 10,
                                                          decoration: Sty()
                                                              .TextFormFieldOutlineStyle
                                                              .copyWith(
                                                                counterText: "",
                                                                hintText:
                                                                    "Enter Mobile Number",
                                                                prefixIconConstraints:
                                                                    BoxConstraints(
                                                                        minWidth:
                                                                            50,
                                                                        minHeight:
                                                                            0),
                                                                suffixIconConstraints:
                                                                    BoxConstraints(
                                                                        minWidth:
                                                                            10,
                                                                        minHeight:
                                                                            2),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                // prefixIcon: Icon(
                                                                //   Icons.phone,
                                                                //   size: iconSizeNormal(),
                                                                //   color: primary(),
                                                                // ),
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Visibility(
                                                  visible: otpsend,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      const Text(
                                                        "One Time Password",
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 2,
                                                                color: Colors
                                                                    .grey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10),
                                                        child: TextFormField(
                                                          controller:
                                                              updateUserOtpController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          maxLength: 4,
                                                          decoration:
                                                              InputDecoration(
                                                            counterText: "",
                                                            hintText:
                                                                "Enter OTP",
                                                            prefixIconConstraints:
                                                                const BoxConstraints(
                                                                    minWidth:
                                                                        50,
                                                                    minHeight:
                                                                        0),
                                                            suffixIconConstraints:
                                                                const BoxConstraints(
                                                                    minWidth:
                                                                        10,
                                                                    minHeight:
                                                                        2),
                                                            border: InputBorder
                                                                .none,
                                                            prefixIcon: Icon(
                                                              Icons.lock,
                                                              color: Clr()
                                                                  .colorblue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: Dim().d8,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Column(
                                                          children: [
                                                            Visibility(
                                                              visible: !again,
                                                              child: TweenAnimationBuilder<
                                                                      Duration>(
                                                                  duration:
                                                                      const Duration(
                                                                          seconds:
                                                                              60),
                                                                  tween: Tween(
                                                                      begin: const Duration(
                                                                          seconds:
                                                                              60),
                                                                      end: Duration
                                                                          .zero),
                                                                  onEnd: () {
                                                                    // ignore: avoid_print
                                                                    // print('Timer ended');
                                                                    setState(
                                                                        () {
                                                                      again =
                                                                          true;
                                                                    });
                                                                  },
                                                                  builder: (BuildContext
                                                                          context,
                                                                      Duration
                                                                          value,
                                                                      Widget?
                                                                          child) {
                                                                    final minutes =
                                                                        value
                                                                            .inMinutes;
                                                                    final seconds =
                                                                        value.inSeconds %
                                                                            60;
                                                                    return Text(
                                                                      "$minutes:$seconds",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: Sty()
                                                                          .mediumBoldText
                                                                          .copyWith(
                                                                              color: Clr().golden),
                                                                    );
                                                                  }),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Visibility(
                                                                  visible:
                                                                      again,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        again =
                                                                            false;
                                                                      });
                                                                      // });
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          "Didn't get it ? ",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Clr().golden,
                                                                              fontFamily: 'NotoSansTaiTham'),
                                                                        ),
                                                                        Text(
                                                                          'Resend OTP',
                                                                          style: Sty()
                                                                              .mediumBoldText
                                                                              .copyWith(color: Clr().golden),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ]),
                                      ),
                                    ),
                                    elevation: 0,
                                    actions: [
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: !otpsend,
                                            child: Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    // API UPDATE START
                                                    SharedPreferences sp =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    FormData body =
                                                        FormData.fromMap({
                                                      'phone':
                                                          updateUserMobileNumberController
                                                              .text,
                                                      'page_type':
                                                          'update_number',
                                                    });
                                                    var result = await STM()
                                                        .post(
                                                            ctx,
                                                            Str().updating,
                                                            'sendOtp',
                                                            body);
                                                    var succes =
                                                        result['success'];
                                                    var message =
                                                        result['message'];
                                                    if (succes) {
                                                      setState(() {
                                                        otpsend = true;
                                                      });
                                                    } else {
                                                      STM.errorDialog(
                                                          context, message);
                                                    }
                                                  }
                                                  // API UPDATE END
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                    color: Clr().golden,
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "Send OTP",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: otpsend,
                                            child: Expanded(
                                              child: InkWell(
                                                  onTap: () {
                                                    // API UPDATE START
                                                    setState(() {
                                                      otpsend = true;
                                                      updatemobile();
                                                    });
                                                    // API UPDATE END

                                                    // API UPDATE END
                                                  },
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      decoration: BoxDecoration(
                                                        color: Clr().golden,
                                                      ),
                                                      child: const Center(
                                                          child: Text(
                                                        "Update",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )))),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Clr().golden,
                                                    ),
                                                    child: const Center(
                                                        child: Text("Cancel",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white))))),
                                          ),
                                        ],
                                      ),
                                    ],
                                    actionsAlignment: MainAxisAlignment.center,
                                  ),
                                );
                              });
                        },
                        child: Icon(
                          Icons.edit,
                          color: Clr().white,
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  GetUserupdate();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Color(0xffffc107),
                  ),
                  child: const Center(
                    child: Text(
                      'UPDATE PROFILE',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'NotoSansTaiTham',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void updateMobileNumber() {
  //   bool otpsend = false;
  //   // var updateUserMobileNumberController;
  //   // updateUserMobileNumberController.text = "";
  //   // updateUserOtpController.text = "";
  //
  // }

  void getuserProfile() async {
    FormData body = FormData.fromMap({
      'user_id': sUserid,
    });
    var result = await STM().post(
      ctx,
      Str().loading,
      'getUser',
      body,
    );
    var succes = result['success'];
    var message = result['message'];
    if (succes) {
      setState(() {
        var form = result['user'];
        userctrl = TextEditingController(text: form['name']);
        mobctrl = TextEditingController(text: form['phone']);
      });
    } else {
      STM.errorDialog(context, message);
    }
  }

  void updatemobile() async {
    FormData body = FormData.fromMap({
      'otp': updateUserOtpController.text,
      'phone': updateUserMobileNumberController.text,
      'user_id': sUserid,
    });
    var result = await STM().post(ctx, Str().updating, 'update_number', body);
    var succes = result['success'];
    var message = result['message'];
    var error = result['error'];
    if (succes) {
      setState(() {
        STM.successDialog(context, message, widget);
      });
    } else {
      STM.errorDialog(context, error);
    }
  }

  void GetUserupdate() async {
    FormData body = FormData.fromMap({
      'user_id': sUserid,
      'name': userctrl.text,
    });
    var result = await STM().post(ctx, Str().updating, 'updateUser', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      setState(() {
        STM.successDialog(ctx, message, widget);
      });
    } else {
      STM.errorDialog(ctx, message);
    }
  }
}
