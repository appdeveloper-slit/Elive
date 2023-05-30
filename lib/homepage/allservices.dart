import 'package:dio/src/form_data.dart';
import 'package:elive/allstatic/colors.dart';
import 'package:elive/allstatic/dimens.dart';
import 'package:elive/allstatic/static_method.dart';
import 'package:elive/allstatic/strings.dart';
import 'package:elive/allstatic/styles.dart';
import 'package:elive/homepage/servicesdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'map.dart';

class AllServices extends StatefulWidget {
  final String? scategoryid;
  final String? sservicename;

  const AllServices({Key? key, this.scategoryid, this.sservicename})
      : super(key: key);

  @override
  State<AllServices> createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  late BuildContext ctx;
  List<dynamic> resultList = [];
  List<dynamic> filterList = [];
  TextEditingController editingController = TextEditingController();
  bool? tap;
  bool listlength = false;
  List<Marker> markerList = [];

  getSessionData() async {
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getallCategory();
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
        title: Text(
          '${widget.sservicename}',
          style: TextStyle(
              fontSize: 18,
              color: Color(0xffFFC107),
              fontFamily: 'NotoSansTaiTham',
              fontWeight: FontWeight.w600),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await Geolocator.requestPermission();
              Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
              );
              if (!mounted) return;
              getData(position.latitude, position.longitude);
            },
            child: SvgPicture.asset(
              'assets/images/gps.svg',
              height: 20,
            ),
          ),
          SizedBox(
            width: Dim().d20,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: Dim().d24,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: editingController,
                  keyboardType: TextInputType.text,
                  onChanged: searchresult,
                  style: Sty().mediumText.copyWith(color: Clr().white),
                  decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                        filled: true,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(Dim().d14),
                          child: SvgPicture.asset(
                            'assets/images/search.svg',
                            color: const Color(0xff747474),
                            height: Dim().d16,
                          ),
                        ),
                        fillColor: Color(0xff333741),
                        hintText: 'Search...',
                        hintStyle:
                            Sty().mediumText.copyWith(color: Color(0xff7F7A7A)),
                      ),
                ),
              ),
              SizedBox(
                width: Dim().d20,
              ),
              // PopupMenuButton(
              //   // ignore: sort_child_properties_last
              //   child: Wrap(
              //     crossAxisAlignment: WrapCrossAlignment.center,
              //     children: [
              //       Image.asset(
              //         'assets/circleimage/filter.png',
              //         height: 18,
              //         width: 21.71,
              //       ),
              //       const Text(
              //         'Sort',
              //         style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.w400,
              //             fontFamily: 'NotoSansTaiTham',
              //             color: Colors.white),
              //       ),
              //     ],
              //   ),
              //   color: Color(0xff333741),
              //   offset: Offset(-40, 19),
              //   itemBuilder: (context) {
              //     return [
              //       PopupMenuItem(
              //         child: Text(
              //           'Top Rate',
              //           style: TextStyle(
              //               fontSize: 12,
              //               fontWeight: FontWeight.w400,
              //               fontFamily: 'NotoSansTaiTham',
              //               color: Colors.white),
              //         ),
              //         onTap: () {
              //           getallCategory(name: 'ok');
              //           setState(() {
              //             tap = true;
              //           });
              //         },
              //       )
              //     ];
              //   },
              // ),
              SizedBox(
                width: Dim().d12,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: listlength!
                  ? Container(
                      height: MediaQuery.of(ctx).size.height / 1.2,
                      child: Center(
                          child: Text(
                        "This category doesn't have any business",
                        style: Sty().mediumText.copyWith(color: Clr().golden),
                      )))
                  : ListView.builder(
                      itemCount: filterList.length,
                      itemBuilder: (context, index) {
                        final category = filterList[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 18.7,
                            right: 16.4,
                            bottom: 25,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              STM.redirect2page(
                                  ctx,
                                  ServicesDetails(
                                    servicename: filterList[index]
                                            ['business_name']
                                        .toString(),
                                    sbusinesId:
                                        filterList[index]['id'].toString(),
                                  ));
                            },
                            child: Container(
                              width: 339.9,
                              decoration: BoxDecoration(
                                  color: Color(0xff333741),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3))),
                              child: Row(
                                children: [
                                  Container(
                                    height: Dim().d140,
                                    width: Dim().d120,
                                    child: Image.network(
                                        'https://sonibro.com/elive/${filterList[index]['logo'].toString()}',
                                        fit: BoxFit.fitHeight),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Dim().d24, top: Dim().d8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text(
                                          filterList[index]['business_name'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'NotoSansTaiTham',
                                              color: Colors.white),
                                        ),
                                        Row(
                                          children: [
                                            Text(filterList[index]['rating_avg_rating'].toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            'NotoSansTaiTham',
                                                        color: Colors.white),
                                                  ),
                                            SizedBox(
                                              width: Dim().d8,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 5.0),
                                              child: RatingBarIndicator(
                                                rating: double.parse(filterList[index]['rating_avg_rating']
                                                        .toString()),
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                unratedColor: Color(0xff7F7A7A),
                                                itemCount: 5,
                                                itemSize: 15.0,
                                                direction: Axis.horizontal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: SizedBox(
                                            width: Dim().d180,
                                            child: Text(
                                              filterList[index]['city'].toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'NotoSansTaiTham',
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Uri phoneno = Uri.parse(
                                                'tel:+91${filterList[index]['business_mobile'].toString()}');
                                            if (await launchUrl(phoneno)) {
                                              //dialer opened
                                            } else {
                                              //dailer is not opened
                                            }
                                          },
                                          child: Container(
                                            height: 29.73,
                                            width: 95.09,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xffFFC107),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(3),
                                                )),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.08,
                                                  top: 5.36,
                                                  bottom: 5.36),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/circleimage/colorcall.png',
                                                    height: 13.17,
                                                    width: 10.25,
                                                  ),
                                                  SizedBox(
                                                    width: 9.68,
                                                  ),
                                                  Text(
                                                    'Call Now',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            'NotoSansTaiTham',
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dim().d12,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
            ),
          ),
        ],
      ),
    );
  }

  void searchresult(String value) {
    if (value.isEmpty) {
      setState(() {
        filterList = resultList;
      });
    }
    else {
      setState(() {
        filterList = resultList.where((element) {
          final resultTitle = element['business_name'].toLowerCase();
          final input = value.toLowerCase();
          return resultTitle.contains(input) || element['city'].toString().toLowerCase().contains(value.toLowerCase());
        }).toList();
      });
    }
  }

  void getallCategory({name}) async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    if (!mounted) return;
    FormData body = FormData.fromMap({
      "category_id": widget.scategoryid,
      'latitude': position.latitude,
      'longitude': position.longitude,
    });
    var result = await STM().post(ctx, Str().loading,
        name != null ? 'filter' : 'get_nearby_business', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      setState(() {
        resultList = result['business'];
        resultList.isEmpty ? listlength = true : listlength = false;
        filterList = resultList;
      });
    } else {
      STM.errorDialog(ctx, message);
    }
  }

  getData(lat, lng) async {
    //Input
    FormData body = FormData.fromMap({
      'latitude': lat,
      'longitude': lng,
      'category_id': widget.scategoryid,
    });
    //Output
    var result = await STM().post(context, Str().loading, "getBusinessByLocation", body);
    var success = result['success'];
    var message = result['message'];
    if(success) {
      setState(() {
        List<dynamic> nearbyList = result['business'];
        print(nearbyList);
        for (int i = 0; i < nearbyList.length; i++) {
          markerList.add(
            Marker(
              markerId: MarkerId('${nearbyList[i]['name']}'),
              position: LatLng(double.parse(nearbyList[i]['latitude']),
                  double.parse(nearbyList[i]['longitude'])),
              onTap: () {
                STM.redirect2page(
                    ctx,
                    ServicesDetails(
                      sbusinesId: nearbyList[i]['id'].toString(),
                      servicename: nearbyList[i]['name'].toString(),
                    ));
              },
            ),
          );
        }
        STM.redirect2page(ctx, Maps(lat, lng, markerList));
      });
    }else{
      STM.errorDialog(ctx, message);
    }
  }
}
