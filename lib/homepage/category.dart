import 'package:dio/dio.dart';
import 'package:elive/allstatic/colors.dart';
import 'package:elive/allstatic/styles.dart';
import 'package:elive/homepage/allservices.dart';
import 'package:elive/homepage/mainhomepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../allstatic/dimens.dart';
import '../allstatic/static_method.dart';
import '../allstatic/strings.dart';
import 'listofbusiness.dart';

class Categorylist extends StatefulWidget {
  const Categorylist({Key? key}) : super(key: key);

  @override
  State<Categorylist> createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {
  late BuildContext ctx;
  List<dynamic> categorieslist = [];
  String? Category_id;
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
    return WillPopScope(onWillPop: () async {
      STM.back2Previous(ctx);
      return false;
    },
      child: Scaffold(
        backgroundColor: Colors.black,
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
            'Select Category',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xffFFC107),
                fontFamily: 'NotoSansTaiTham',
                fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Dim().d40,
              ),
              Container(
                height: 900.0,
                width: 900,
                padding: EdgeInsets.only(top: 10, left: 10),
                child: GridView.builder(
                    itemCount: categorieslist.length,
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,mainAxisExtent: Dim().d150),
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          STM.redirect2page(ctx, Listofbuisness(SCategoryid: categorieslist[index]['id'].toString(),page: 1,));
                        },
                        child: SizedBox(
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
              // Padding(
              //   padding: const EdgeInsets.only(
              //     left: 20.0,
              //     right: 20,
              //   ),
              //   child: GestureDetector(
              //     onTap: () {
              //       //                Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(builder: (context) => const Bottomnavigation()),
              //       // );
              //     },
              //     child: Container(
              //       height: 50,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(6.0),
              //         color: const Color(0xffffc107),
              //       ),
              //       child: const Center(
              //         child: Text(
              //           'CONTINUE',
              //           style: TextStyle(
              //             fontSize: 16,
              //             color: Colors.white,
              //             fontFamily: 'NotoSansTaiTham',
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void GetServices() async {
    FormData body = FormData.fromMap({});
    var result = await STM().post(ctx, Str().loading, 'getallCategory', body);
    var success = result['success'];
    if (success) {
      setState(() {
        categorieslist = result['category'];
      });
    } else {
      STM.errorDialog(ctx, 'Category Not Available');
    }
  }
}
