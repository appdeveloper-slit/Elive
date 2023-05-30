import 'package:dio/dio.dart';
import 'package:elive/allstatic/static_method.dart';
import 'package:elive/allstatic/strings.dart';
import 'package:elive/allstatic/styles.dart';
import 'package:elive/homepage/mainhomepage.dart';
import 'package:elive/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late BuildContext ctx;
  List<dynamic> notificationlist = [];
  String? sUser;

  getSessionData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      sUser = sp.getString("user_id") ?? "";
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getNotification();
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xff333741),
        leading: GestureDetector(
          onTap: () {
            STM.finishAffinity(ctx, MainHomePage());
          },
          // ignore: prefer_const_constructors
          child: Icon(
            Icons.arrow_back_ios,
            color: const Color(0xffffc107),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(
              fontSize: 18,
              color: Color(0xffFFC107),
              fontFamily: 'NotoSansTaiTham',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        height: 900,
        child: notificationlist.isEmpty
            ? Center(
                child: Text(
                  'No Notifications',
                  style: Sty().mediumText.copyWith(
                        color: Color(0xffFFC107),
                      ),
                ),
              )
            : ListView.builder(
                itemCount: notificationlist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                      left: 18.6,
                      right: 16.4,
                    ),
                    child: Container(
                      width: 340.01,
                      decoration: const BoxDecoration(
                          color: const Color(0xff333741),
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.27, left: 13.29),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              notificationlist[index]['title'].toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'NotoSansTaiTham',
                                  color: Color(0xffFFC107),
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              '${notificationlist[index]['description'].toString()}',
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${notificationlist[index]['created_on'].toString()}',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'NotoSansTaiTham',
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }

  void getNotification() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("time", DateTime.now().toString());
    FormData body = FormData.fromMap({
      'user_id': sUser,
    });
    var result =
        await STM().post(ctx, Str().loading, 'getAllNotification', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      setState(() {
        notificationlist = result['notifications'];
      });
    } else {}
  }
}
