import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_url.dart';
import 'colors.dart';
import 'dimens.dart';
import 'styles.dart';

class STM {
  static void redirect2page(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static void back2Previous(BuildContext context) {
    Navigator.pop(context);
  }

  static void displayToast(String string) {
    Fluttertoast.showToast(msg: string, toastLength: Toast.LENGTH_SHORT,textColor: Clr().white);
  }

  static void replacePage(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
    );
  }

  static openWeb(String url) async {
    await launchUrl(Uri.parse(url.toString()));
  }

  static void finishAffinity(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
  }

  static void successDialog(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            headerAnimationLoop: true,
            title: 'Success',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              STM.finishAffinity(context, widget);
            },
            btnOkColor: Clr().successGreen)
        .show();
  }

  static void successDialogWithAffinity(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            headerAnimationLoop: true,
            title: 'Success',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => widget,
                ),
                (Route<dynamic> route) => false,
              );
            },
            btnOkColor: Clr().successGreen)
        .show();
  }

  static void successDialogWithReplace(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            headerAnimationLoop: true,
            title: 'Success',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => widget,
                ),
              );
            },
            btnOkColor: Clr().successGreen)
        .show();
  }

  static void errorDialog(BuildContext context, String message) {
    AwesomeDialog(
            context: context,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            headerAnimationLoop: true,
            title: 'Note',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {},
            btnOkColor: Clr().errorRed)
        .show();
  }

  static void errorDialogWithReplace(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            headerAnimationLoop: true,
            title: 'Note',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => widget,
                ),
              );
            },
            btnOkColor: Clr().errorRed)
        .show();
  }

  static AwesomeDialog loadingDialog(BuildContext context, String title) {
    AwesomeDialog dialog = AwesomeDialog(
      width: 250,
      context: context,
      dismissOnBackKeyPress: true,
      dismissOnTouchOutside: false,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.SCALE,
      body: WillPopScope(
        onWillPop: () async {
          displayToast('Something went wrong try again.');
          return true;
        },
        child: Container(
          height: Dim().d160,
          padding: EdgeInsets.all(Dim().d16),
          decoration: BoxDecoration(
            color: Clr().white,
            borderRadius: BorderRadius.circular(Dim().d32),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(Dim().d12),
                child: SpinKitCubeGrid(
                  color: Clr().black,
                ),
              ),
              SizedBox(
                height: Dim().d16,
              ),
              Text(
                title,
                style: Sty().mediumBoldText.copyWith(
                      color: Clr().golden,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
    return dialog;
  }

  static void alertDialog(context, message, widget) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        AlertDialog dialog = AlertDialog(
          title: Text(
            "Confirmation",
            style: Sty().largeText,
          ),
          content: Text(
            message,
            style: Sty().smallText,
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {},
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        return dialog;
      },
    );
  }

  static AwesomeDialog modalDialog(BuildContext context, Widget widget) {
    AwesomeDialog dialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.SCALE,
      body: widget,
    );
    return dialog;
  }

  static void mapDialog(BuildContext context, Widget widget) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      padding: EdgeInsets.zero,
      animType: AnimType.SCALE,
      body: widget,
      btnOkText: 'Done',
      btnOkColor: Clr().successGreen,
      btnOkOnPress: () {},
    ).show();
  }

  static Widget setSVG(name, size, color) {
    return SvgPicture.asset(
      'assets/$name.svg',
      height: size,
      width: size,
      color: color,
    );
  }

  static Widget emptyData(message) {
    return Center(
      child: Text(
        message,
        style: Sty().smallText.copyWith(
              color: Clr().primaryColor,
              fontSize: 18.0,
            ),
      ),
    );
  }

  static List<BottomNavigationBarItem> getBottomList(index) {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/images/home.svg', height: 21),
        label: 'Home',
      ),
      BottomNavigationBarItem(
          // ignore: prefer_const_constructors
          icon: SvgPicture.asset('assets/images/settings.svg', height: 21),
          label: 'Services'),
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/images/myprofile.svg'),
          label: 'Profile'),
    ];
  }

  //Dialer
  static Future<void> openDialer(String phoneNumber) async {
    Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(Uri.parse(launchUri.toString()));
  }

  //WhatsApp
  static Future<void> openWhatsApp(String phoneNumber) async {
    if (Platform.isIOS) {
      await launchUrl(Uri.parse("whatsapp:wa.me/$phoneNumber"));
    } else {
      await launchUrl(Uri.parse("whatsapp:send?phone=$phoneNumber"));
    }
  }

  Future<bool> checkInternet(context, widget) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      internetAlert(context, widget);
      return false;
    }
  }

  internetAlert(context, widget) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.SCALE,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body: Padding(
        padding: EdgeInsets.all(Dim().d20),
        child: Column(
          children: [
            // SizedBox(child: Lottie.asset('assets/no_internet_alert.json')),
            Text(
              'Connection Error',
              style: Sty().largeText.copyWith(
                color: Clr().primaryColor,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: Dim().d8,
            ),
            Text(
              'No Internet connection found.',
              style: Sty().smallText,
            ),
            SizedBox(
              height: Dim().d32,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: Sty().primaryButton,
                onPressed: () async{
                  var connectivityResult = await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                    Navigator.pop(context);
                    STM.replacePage(context, widget);
                  }
                },
                child: Text(
                  "Try Again",
                  style: Sty().largeText.copyWith(
                    color: Clr().white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    ).show();
  }


  Future<dynamic> postwithreso(ctx, title, name, body) async {
    //Dialog
    AwesomeDialog dialog = STM.loadingDialog(ctx, title);
    dialog.show();
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
    String url = AppUrl.mainUrl + name;
    dynamic result;
    try {
      Response response = await dio.post(url, data: body);
      if (kDebugMode) {
        print("Url = $url\nBody = ${body.fields}\nResponse = $response");
      }
      if (response.statusCode == 200) {
        dialog.dismiss();
        result = response.data;
      }
    } on DioError catch (e) {
    }
    return result;
  }

  Future<dynamic> post(ctx, title, name, body) async {
    //Dialog
    AwesomeDialog dialog = STM.loadingDialog(ctx, title);
    dialog.show();
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
    String url = AppUrl.mainUrl + name;
    dynamic result;
    try {
      Response response = await dio.post(url, data: body);
      if (kDebugMode) {
        print("Url = $url\nBody = ${body.fields}\nResponse = $response");
      }
      if (response.statusCode == 200) {
        dialog.dismiss();
        result = json.decode(response.data.toString());
      }
    } on DioError catch (e) {
    }
    return result;
  }
  Future<dynamic> get(ctx, name) async {
    //Dialog
    // AwesomeDialog dialog = STM.loadingDialog(ctx, title);
    // dialog.show();
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
    String url = AppUrl.mainUrl + name;
    dynamic result;
    try {
      Response response = await dio.get(url);
      if (kDebugMode) {
        print("Response = $response");
      }
      if (response.statusCode == 200) {
        // dialog.dismiss();
        result = json.decode(response.data.toString());
      }
    } on DioError catch (e) {
    }
    return result;
  }
  Future<dynamic> postget(ctx, title, name, body, token) async {
    //Dialog
    AwesomeDialog dialog = STM.loadingDialog(ctx, title);
    dialog.show();
    Dio dio = Dio(
      BaseOptions(
        headers: {
          "Content-Type": "application/json",
          "responseType": "ResponseType.plain",
          "Authorization": "Bearer $token",
          // "Authorization": "Bearer i6jO6wmzaAcSSY63aMl1FYELe0q6Vznta2s3XAlp",
        },
      ),
    );
    String url = AppUrl.mainUrl + name;
    if (kDebugMode) {
      print("Url = $url\nBody = ${body.fields}");
    }
    dynamic result;
    try {
      Response response = await dio.post(url, data: body);
      if (kDebugMode) {
        print("Response = $response");
      }
      if (response.statusCode == 200) {
        dialog.dismiss();
        result = response.data;
      }
    } on DioError catch (e) {
    }
    return result;
  }

  Future<dynamic> postlist(ctx, title, name, token) async {
    //Dialog
    AwesomeDialog dialog = STM.loadingDialog(ctx, title);
    dialog.show();
    Dio dio = Dio(
      BaseOptions(
        headers: {
          "Content-Type": "application/json",
          "responseType": "ResponseType.plain",
          "Authorization": "Bearer $token",
        },
      ),
    );
    String url = AppUrl.mainUrl + name;
    // if (kDebugMode) {
    //   // print("Url = $url\nBody = ${body.fields}");
    // }
    dynamic result;
    try {
      Response response = await dio.get(url);
      if (kDebugMode) {
        print("Response = $response");
      }
      if (response.statusCode == 200) {
        dialog.dismiss();
        // result = json.decode(response.data.toString());
        result = response.data;
      }
    } on DioError catch (e) {
    }
    return result;
  }
  Future<dynamic> postWithoutDialog2(name, body) async {
    //Dialog
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
    String url = AppUrl.mainUrl + name;
    dynamic result;
    try {
      Response response = await dio.post(url, data: body);
      if (kDebugMode) {
        print("Url = $url\nBody = ${body.fields}\nResponse = $response");
      }
      if (response.statusCode == 200) {
        result = json.decode(response.data.toString());
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return result;
  }


  static String dateFormat(format, date) {
    return DateFormat(format).format(date).toString();
  }
}
