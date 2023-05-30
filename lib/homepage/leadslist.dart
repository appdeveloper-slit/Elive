import 'package:dio/dio.dart';
import 'package:elive/allstatic/dimens.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../allstatic/static_method.dart';
import '../allstatic/strings.dart';

class LeadsList extends StatefulWidget {
  const LeadsList({Key? key}) : super(key: key);

  @override
  State<LeadsList> createState() => _LeadsListState();
}

class _LeadsListState extends State<LeadsList> {
  late BuildContext ctx;
  List<dynamic> resultList = [];
  String? sUserid;

  getSessionData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      sUserid = sp.getString("user_id") ?? "";
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getData();
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
            Navigator.pop(context);
          },
          // ignore: prefer_const_constructors
          child: Icon(
            Icons.arrow_back_ios,
            color: const Color(0xffffc107),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Leads',
          style: TextStyle(
              fontSize: 18,
              color: Color(0xffFFC107),
              fontFamily: 'NotoSansTaiTham',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(
          Dim().pp,
        ),
        itemCount: resultList.length,
        itemBuilder: (context, index) {
          return itemLayout(ctx, index, resultList);
        },
      ),
    );
  }

  Widget itemLayout(ctx, index, list) {
    dynamic v = list[index];
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Container(
        height: 125,
        width: 339,
        decoration: const BoxDecoration(
            color: Color(0xff333741),
            borderRadius: BorderRadius.all(Radius.circular(3))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 12.4, bottom: 10),
              child: Row(
                children: [
                  Text(
                    '${v['business_location']}',
                    // 'Kalyan (w)',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'NotoSansTaiTham',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 12.3,
                  ),
                  Text(
                    '${v['created_at']}',
                    // '27 Sep 2022, 01:15 pm',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'NotoSansTaiTham',
                      fontWeight: FontWeight.w400,
                      color: Color(0xff8C8C8C),
                    ),
                  ),
                ],
              ),
            ),
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.only(left: 12.4),
              child: Text(
                '${v['name']}',
                // 'Aniket Mahakal',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'NotoSansTaiTham',
                  fontWeight: FontWeight.w400,
                  color: Color(0xff8C8C8C),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 12.4,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      STM.openDialer(v['phone']);
                    },
                    child: Container(
                      height: 29.73,
                      width: 95.09,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffFFC107),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(3),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.08, top: 5.36, bottom: 5.36),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/circleimage/colorcall.png',
                              height: 13.17,
                              width: 10.25,
                            ),
                            const SizedBox(
                              width: 9.68,
                            ),
                            const Text(
                              'Call Now',
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
                  ),
                  const SizedBox(
                    width: 26.98,
                  ),
                  InkWell(
                    onTap: () {
                      launchWhatsApp(v['phone']);
                    },
                    child: Container(
                      height: 29.73,
                      width: 95.09,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffFFC107),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(3),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.08, top: 5.36, bottom: 5.36),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/circleimage/whatsapp.png',
                              height: 18.25,
                              width: 14.41,
                            ),
                            const SizedBox(
                              width: 9.68,
                            ),
                            const Text(
                              'Message',
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  launchWhatsApp(phone) async {
    final link = WhatsAppUnilink(
      phoneNumber: '+91$phone',
      text: "Hey!",
    );
    await launch('$link');
  }

  void getData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    FormData body = FormData.fromMap({'user_id': sUserid});
    var result = await STM().post(ctx, Str().loading, 'leads', body);
    setState(() {
      resultList = result['leads'];
    });
  }
}
