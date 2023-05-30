// ignore_for_file: prefer_const_constructors
import 'dart:ui';
import 'package:elive/allstatic/colors.dart';
import 'package:elive/allstatic/dimens.dart';
import 'package:elive/allstatic/styles.dart';
import 'package:elive/fullimage.dart';
import 'package:flutter/material.dart';
import 'package:dio/src/form_data.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../allstatic/static_method.dart';
import '../allstatic/strings.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ServicesDetails extends StatefulWidget {
  final String? sbusinesId;
  final String? servicename;

  const ServicesDetails({Key? key, this.sbusinesId, this.servicename})
      : super(key: key);

  @override
  State<ServicesDetails> createState() => _ServicesDetailsState();
}

class _ServicesDetailsState extends State<ServicesDetails> {
  late BuildContext ctx;
  var businessdetailslist = {};
  var sUser;
  double? rating;
  double? globalrating;
  getSessionData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      sUser = sp.getString("user_id") ?? "";
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        viewbusiness();
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
          title: Text(
            '${widget.servicename}',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xffFFC107),
                fontFamily: 'NotoSansTaiTham',
                fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 25),
              //   child: Container(
              //     height: 43.71,
              //     decoration: const BoxDecoration(
              //       color: Color(0xff333741),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.only(
              //           left: 30.15, top: 10.85, bottom: 10.86),
              //       child: Row(
              //         children: [
              //           SvgPicture.asset('assets/images/search.svg'),
              //           // ignore: prefer_const_constructors
              //           SizedBox(
              //             width: 19.24,
              //           ),
              //           const Text(
              //             'Weather Cool Engineers',
              //             style: TextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w400,
              //                 fontFamily: 'NotoSansTaiTham',
              //                 color: Color(0xff7F7A7A)),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: Dim().d28,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    STM.redirect2page(
                        ctx,
                        FullImage(
                            'https://sonibro.com/elive/${businessdetailslist['logo'].toString()}'));
                  },
                  child: Container(
                    height: Dim().d180,
                    width: Dim().d340,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(Dim().d12),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://sonibro.com/elive/${businessdetailslist['logo'].toString()}'),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
              SizedBox(
                height: Dim().d24,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 18.7,
                ),
                child: Text(
                  businessdetailslist['business_name'].toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'NotoSansTaiTham',
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 18.7,
                ),
                child: Text(
                  businessdetailslist['shop_number'].toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NotoSansTaiTham',
                    color: Color(0xff7F7A7A),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.38,
                  left: 18.7,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                     Text(
                      '${globalrating}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'NotoSansTaiTham',
                          color: Colors.white),
                    ),
                     SizedBox(
                      width:Dim().d4,
                    ),
                    RatingBarIndicator(
                      rating: globalrating ?? 0,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      unratedColor: Color(0xff7F7A7A),
                      itemCount: 5,
                      itemSize: 17.0,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  left: 18.7,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        Uri phoneno = Uri.parse(
                            'tel:+91${businessdetailslist['business_mobile'].toString()}');
                        if (await launchUrl(phoneno)) {
                          //dialer opened
                        } else {
                          //dailer is not opened
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 156.46,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffFFC107),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25.88, top: 5.36, bottom: 5.36),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/circleimage/colorcall.png',
                                height: 20.17,
                                width: 15.7,
                              ),
                              const SizedBox(
                                width: 9.68,
                              ),
                              const Text(
                                'Call Now',
                                style: TextStyle(
                                    fontSize: 16,
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
                        MapsLauncher.launchCoordinates(
                            double.parse(
                                businessdetailslist['latitude'].toString()),
                            double.parse(
                                businessdetailslist['longitude'].toString()));
                      },
                      child: Container(
                        height: 50,
                        width: 156.46,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffFFC107),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25.88, top: 5.36, bottom: 5.36),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/gps.svg',
                                height: 18.25,
                                width: 14.41,
                              ),
                              const SizedBox(
                                width: 9.68,
                              ),
                              const Text(
                                'Directions',
                                style: TextStyle(
                                    fontSize: 16,
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
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Divider(
                  color: Color(0xff333741),
                  thickness: 0.50,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.37, left: 20.07, bottom: 15),
                child: Text(
                  'Rate this',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'NotoSansTaiTham',
                      color: Color(0xffFFC107)),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Dim().d20),
                    child: RatingBar.builder(
                      initialRating: rating ?? 0.0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      unratedColor: Color(0xff7F7A7A),
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rate) {
                        print(rating);
                        setState(() {
                          rating = rate;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: Dim().d12,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffFFC107)),
                    ),
                    onPressed: () {
                      Giverating();
                    },
                    child: Center(
                      child: Text(
                        'Submit',
                        style: Sty().mediumText.copyWith(color: Clr().white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dim().d20,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Divider(
                  color: Color(0xff333741),
                  thickness: 0.50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20.07, bottom: 15),
                child: Text(
                  'Photos',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'NotoSansTaiTham',
                      color: Color(0xffFFC107)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20.07, bottom: 15),
                child: GridView.builder(
                    itemCount: businessdetailslist['image'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            STM.redirect2page(
                                ctx,
                                FullImage(
                                    'https://sonibro.com/elive/${businessdetailslist['image'][index]['image_path'].toString()}'));
                          },
                          child: Container(
                            height: Dim().d100,
                            width: Dim().d100,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(Dim().d12)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://sonibro.com/elive/${businessdetailslist['image'][index]['image_path'].toString()}'),
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 21),
                child: Divider(
                  color: Color(0xff333741),
                  thickness: 0.50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.6, bottom: 20.93),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/blackwatch.png',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      width: 13.67,
                    ),
                    Text(
                      'Open Now',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'NotoSansTaiTham',
                          color: Color(0xff0073DD)),
                    ),
                    Text(' ${businessdetailslist['business_office_time_from'].toString()} - ${businessdetailslist['business_office_time_to'].toString()}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'NotoSansTaiTham',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Divider(
                  color: Color(0xff333741),
                  thickness: 0.50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void viewbusiness() async {
    FormData body = FormData.fromMap({
      "user_id": sUser,
      "business_id": widget.sbusinesId,
    });
    var result = await STM().post(ctx, Str().loading, 'ViewBusinesss', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      setState(() {
        businessdetailslist = result['business'];
        double p = double.parse(result['business']['rating_avg_rating'].toString());
        double b = double.parse(result['given_rating'] == null ? "0" : result['given_rating']['rating'].toString());
        rating = b;
        globalrating = p;
      });
    } else {
      STM.errorDialog(ctx, message);
    }
  }

  void Giverating() async {
    FormData body = FormData.fromMap({
      "user_id": sUser,
      "business_id": widget.sbusinesId,
      "rating": rating,
    });
    var result = await STM().post(ctx, Str().submitting, 'rating', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM.successDialogWithReplace(ctx, message, widget);
      // STM.displayToast(message);
    } else {
      STM.errorDialog(ctx, message);
    }
  }
}
