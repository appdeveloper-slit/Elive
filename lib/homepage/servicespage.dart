// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:elive/homepage/allservices.dart';
import 'package:elive/homepage/bottomnavigation.dart';
import 'package:elive/homepage/mainhomepage.dart';
import 'package:elive/homepage/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../allstatic/bottom_navigation.dart';
import '../allstatic/dimens.dart';
import '../allstatic/static_method.dart';
import '../allstatic/strings.dart';
import 'listofbusiness.dart';

class Servicespage extends StatefulWidget {
  const Servicespage({Key? key}) : super(key: key);

  @override
  State<Servicespage> createState() => _ServicespageState();
}

class _ServicespageState extends State<Servicespage> {
  late BuildContext ctx;
  List<dynamic> categorieslist = [];
  String? sUser;
  getSessionData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      sUser = sp.getString("user_id") ?? "";
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        GetServices();
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
      onWillPop: ()async{
        STM.back2Previous(ctx);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          bottomNavigationBar: bottomBarLayout(ctx, 1),
          appBar: AppBar(
            backgroundColor: Color(0xff333741),
            leading: GestureDetector(
              onTap: ()  {
                STM.back2Previous(ctx);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffffc107),
              ),
            ),
            title: Text(
              'Services',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'NotoSansTaiTham',
                  fontWeight: FontWeight.w600,
                  color: Color(0xffffc107)),
            ),
            centerTitle: true,
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(right: 18.0),
            //     child: GestureDetector(
            //         onTap: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(builder: (context) => const Maps()),
            //           );
            //         },
            //         child: SvgPicture.asset(
            //           'assets/images/gps.svg',
            //           height: 17,
            //         )),
            //   ),
            // ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(top: 40.0, bottom: 30.0),
                //       child: Container(
                //         height: 43.71,
                //         width: 175,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.only(
                //               topRight: Radius.circular(6.0),
                //               bottomRight: Radius.circular(6.0),
                //             ),
                //             color: Color(0xff333741)),
                //         child: Padding(
                //           padding: const EdgeInsets.only(left: 19.4),
                //           child: Row(
                //             children: [
                //               SvgPicture.asset(
                //                 'assets/images/location.svg',
                //                 color: Color(0xff747474),
                //                 height: 15.38,
                //               ),
                //               SizedBox(
                //                 width: 13.18,
                //               ),
                //               Text(
                //                 'Link Road M,...',
                //                 style: TextStyle(
                //                     color: Color(0xff767273),
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w400,
                //                     fontFamily: 'NotoSansTaiTham'),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(top: 40.0, bottom: 30),
                //       child: Container(
                //         height: 43.71,
                //         width: 175,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(6.0),
                //               bottomLeft: Radius.circular(6.0),
                //             ),
                //             color: Color(0xff333741)),
                //         child: Padding(
                //           padding: const EdgeInsets.only(left: 25.84),
                //           child: Row(
                //             children: [
                //               SvgPicture.asset(
                //                 'assets/images/search.svg',
                //                 color: Color(0xff747474),
                //                 height: 17,
                //               ),
                //               SizedBox(
                //                 width: 8.33,
                //               ),
                //               Text(
                //                 'Search,...',
                //                 style: TextStyle(
                //                     color: Color(0xff767273),
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w400,
                //                     fontFamily: 'NotoSansTaiTham'),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: Dim().d20,),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'Services',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffe0a906),
                            fontFamily: 'NotoSansTaiTham',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Divider(
                      color: Color(0xffe0a906),
                      height: 15,
                      thickness: 2,
                      endIndent: 330.0),
                ),
                SizedBox(height: Dim().d14,),
                Container(
                  height: 900.0,
                  width: 900.0,
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: GridView.builder(
                      itemCount: categorieslist.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, mainAxisExtent: 150),
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllServices(
                                    sservicename:categorieslist[index]['name'].toString(),
                                    scategoryid: categorieslist[index]['id'].toString(),
                                      )),
                            );
                          },
                          child: Container(
                            height: 190,
                            width: 100,
                            child: Column(
                              children: [
                                Container(
                                  height: Dim().d80,
                                  width: Dim().d80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(Dim().d52),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://sonibro.com/elive/${categorieslist[index]['img_path'].toString()}'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(
                                  height: 4.76,
                                ),
                                Container(
                                  width: 70,
                                  padding: EdgeInsets.only(left: 11, bottom: 20),
                                  child: Text(
                                    categorieslist[index]['name'],
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontFamily: 'NotoSansTaiTham',
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void GetServices() async {
    FormData body = FormData.fromMap({});
    var result = await STM().post(ctx, Str().loading, 'getallCategory', body);
    var success = result['success'];
    var message = result[''];
    if (success) {
      setState(() {
        categorieslist = result['category'];
      });
    } else {
      STM.errorDialog(ctx, message);
    }
  }
}
