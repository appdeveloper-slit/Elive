import 'dart:async';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:elive/homepage/servicesdetails.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:elive/allstatic/bottom_navigation.dart';
import 'package:elive/allstatic/colors.dart';
import 'package:elive/allstatic/dimens.dart';
import 'package:elive/allstatic/strings.dart';
import 'package:elive/allstatic/styles.dart';
import 'package:elive/homepage/allservices.dart';
import 'package:elive/homepage/blog.dart';
import 'package:elive/homepage/category.dart';
import 'package:elive/homepage/map.dart';
import 'package:elive/homepage/notification.dart';
import 'package:elive/homepage/sidedrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../allstatic/static_method.dart';
import '../signup/signin.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

Future<void> initializeService() async {
  FlutterBackgroundService service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  Timer.periodic(Duration(minutes: 5), (timer) async {
    GetHome();
  });
}

void GetHome() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  FormData body = FormData.fromMap({
  'user_id': sp.getString("user_id"),
  'latitude': position.latitude,
  'longitude': position.longitude,
  'time': sp.getString('time') ?? "0000-00-00 00:00:00",
  });
  var result = STM().postWithoutDialog2('home', body);
}

class _MainHomePageState extends State<MainHomePage> {
  late BuildContext ctx;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? sUser;
  List<dynamic> sliderList = [];
  List<dynamic> blogList = [];
  List<dynamic> categorieslist = [];
  List testomonialtitle = [
    'Its easy to search nearby serviceable stores.',
    'Unique interface, quick response from vendors',
    'Great working and professionals are listed',
    'I thank my friend to introduce, its easy-to-get nearby service centres',
    'Go-to application for me is ELIVE – I can get anything I want.',
  ];
  dynamic businessreview;
  dynamic notification;
  // List<Marker> markerList = [];

  getSessionData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (!mounted) return;
    setState(() {
      sUser = sp.getString("user_id") ?? "";
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        GetHome(latti: position.latitude, longi: position.longitude, b: false);
      }
    });
    initializeService();
  }

  Future<void> initializeService() async {
    FlutterBackgroundService service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
    service.startService();
  }

  @override
  void initState() {
    getSessionData();
    super.initState();
  }

  //Api Method
  // getData(lat, lng) async {
  //   //Input
  //   FormData body = FormData.fromMap({
  //     'latitude': lat,
  //     'longitude': lng,
  //   });
  //   //Output
  //   var result =
  //       await STM().post(context, Str().loading, "getBusinessByLocation", body);
  //   if (!mounted) return;
  //   setState(() {
  //     List<dynamic> nearbyList = result['business'];
  //     print(nearbyList);
  //     for (int i = 0; i < nearbyList.length; i++) {
  //       markerList.add(
  //         Marker(
  //           markerId: MarkerId('${nearbyList[i]['name']}'),
  //           position: LatLng(double.parse(nearbyList[i]['latitude']),
  //               double.parse(nearbyList[i]['longitude'])),
  //           onTap: () {
  //             STM.redirect2page(
  //                 ctx,
  //                 ServicesDetails(
  //                   sbusinesId: nearbyList[i]['id'].toString(),
  //                   servicename: nearbyList[i]['name'].toString(),
  //                 ));
  //           },
  //         ),
  //       );
  //     }
  //     STM.redirect2page(ctx, Maps(lat, lng, markerList));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return DoubleBack(
      message: 'Press back once again to exit',
      child: Scaffold(
        key: scaffoldKey,
        drawer: navDrawer(ctx, scaffoldKey),
        backgroundColor: Colors.black,
        bottomNavigationBar: bottomBarLayout(ctx, 0),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff333741),
          leading: Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 26.42, top: 18, bottom: 18),
                child: SvgPicture.asset(
                  'assets/images/vector.svg',
                ),
              ),
            );
          }),
          title: Container(
            height: 50,
            child: ClipRRect(
                child: Image.asset(
              'assets/circleimage/whitelogo.png',
            )),
          ),
          centerTitle: true,
          actions: [
            // ignore: sized_box_for_whitespace
            Container(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // GestureDetector(
                  //   onTap: () async {
                  //     await Geolocator.requestPermission();
                  //     Position position = await Geolocator.getCurrentPosition(
                  //       desiredAccuracy: LocationAccuracy.high,
                  //     );
                  //     if (!mounted) return;
                  //     getData(position.latitude, position.longitude);
                  //   },
                  //   child: SvgPicture.asset(
                  //     'assets/images/gps.svg',
                  //     height: 20,
                  //   ),
                  // ),
                  SizedBox(
                    width: Dim().d14,
                  ),
                  GestureDetector(
                    onTap: () {
                      STM.redirect2page(ctx, const Categorylist());
                    },
                    child: SvgPicture.asset(
                      'assets/images/add.svg',
                      height: 20,
                    ),
                  ),
                  SizedBox(
                    width: Dim().d14,
                  ),
                  GestureDetector(
                    onTap: () {
                      STM.redirect2page(ctx, const Notifications());
                    },
                    child: Stack(
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            'assets/images/notification.svg',
                            height: 20,
                          ),
                        ),
                        notification == true
                            ? Positioned(
                                top: 18,
                                right: 0,
                                child: Container(
                                  height: Dim().d8,
                                  width: Dim().d8,
                                  decoration: BoxDecoration(
                                    color: Clr().red,
                                    shape: BoxShape.circle,
                                  ),
                                ))
                            : Container(),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Dim().d20,
                  ),
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: Dim().d28),
                padding: EdgeInsets.symmetric(
                  vertical: Dim().d2,
                  horizontal: Dim().d20,
                ),
                color: businessreview == '0'
                    ? const Color(0xffFF6B00)
                    : businessreview == null
                        ? Clr().black
                        : businessreview == '1'
                            ? Clr().black
                            : const Color(0xffFF2525),
                child: Text(
                  businessreview == '0'
                      ? 'Your Profile is under review'
                      : businessreview == null
                          ? ''
                          : businessreview == '1'
                              ? ''
                              : 'Your profile Rejected,Please upload again',
                  textAlign: TextAlign.center,
                  style: Sty().mediumText.copyWith(color: Clr().white),
                ),
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    ),
                    items: sliderList
                        .map((item) => Container(
                              height: Dim().d250,
                              width: Dim().d300,
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                  child: Image.network(
                                    'https://sonibro.com/elive/${item['img_path']}',
                                    fit: BoxFit.cover,
                                    height: 174.3,
                                    width: 330.58,
                                  )),
                            ))
                        .toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 21.13),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
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
              const Padding(
                padding: EdgeInsets.only(left: 21.13),
                child: Divider(
                    color: Color(0xffe0a906),
                    height: 15,
                    thickness: 1,
                    endIndent: 340.0),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 3 / 4),
                    itemCount: categorieslist.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          STM.redirect2page(
                              ctx,
                              AllServices(
                                sservicename:
                                    categorieslist[index]['name'].toString(),
                                scategoryid:
                                    categorieslist[index]['id'].toString(),
                              ));
                          print(categorieslist[index]['id']);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: Dim().d100,
                              width: Dim().d100,
                              margin: EdgeInsets.only(right: Dim().d12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(Dim().d100),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://sonibro.com/elive/${categorieslist[index]['img_path'].toString()}'),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            SizedBox(
                              height: Dim().d4,
                            ),
                            SizedBox(
                              width: Dim().d120,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  categorieslist[index]['name'],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontFamily: 'NotoSansTaiTham',
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 2,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    })),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 21.13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'Testimonials',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffe0a906),
                          fontFamily: 'NotoSansTaiTham',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 21.13),
                child: Divider(
                    color: Color(0xffe0a906),
                    height: 15,
                    thickness: 1,
                    endIndent: 340.0),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 10.0, top: 10, left: 12.0),
                child: Container(
                  height: Dim().d80,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: testomonialtitle.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Container(
                              width: Dim().d320,
                              decoration: BoxDecoration(
                                // image: DecorationImage(image: AssetImage('assets/testo.jpg')),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dim().d12)),
                                color: Clr().white,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: Dim().d12),
                                child: Center(
                                  child: Text(
                                    '${testomonialtitle[index]}',
                                    style: Sty().mediumBoldText,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              )
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 15.0),
                              //   child: ClipRRect(
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(6.0)),
                              //     child: Image.asset(
                              //       'assets/testo.jpg',
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              // ),
                              ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 21.13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'Blog',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffe0a906),
                          fontFamily: 'NotoSansTaiTham',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 21.13),
                child: Divider(
                    color: Color(0xffe0a906),
                    height: 15,
                    thickness: 1,
                    endIndent: 340.0),
              ),
              Container(
                height: 240,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: blogList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            STM.redirect2page(ctx, BlogPage(blogList[index]));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: Dim().d4,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Dim().d12,
                                ),
                                color: Clr().white),
                            width: MediaQuery.of(ctx).size.width / 1.2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 140,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(Dim().d12),
                                      topRight: Radius.circular(Dim().d12),
                                    ),
                                    child: Image.network(
                                      'https://sonibro.com/elive/${blogList[index]['img_path'].toString()}',
                                      fit: BoxFit.cover,
                                      height: 140,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Dim().d4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    blogList[index]['title'].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Sty().largeText,
                                  ),
                                ),
                                SizedBox(
                                  height: Dim().d4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    blogList[index]['description'].toString(),
                                    style: Sty().smallText,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void GetHome({latti, longi, b}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print(sUser);
    FormData body = FormData.fromMap({
      'user_id': sUser,
      'latitude': latti,
      'longitude': longi,
      'time': sp.getString('time') ?? "0000-00-00 00:00:00",
    });
    var result = b
        ? await STM().postWithoutDialog2('home', body)
        : await STM().post(ctx, Str().loading, 'home', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      setState(() {
        sliderList = result['sliders'];
        blogList = result['blogs'];
        categorieslist = result['categories'];
        notification = result['is_notification'];
        if (result['user_status'] == 0) {
          sp.clear();
          STM.finishAffinity(ctx, const Signup());
        }
        businessreview = result['business_status'];
      });
    } else {
      STM.errorDialog(ctx, message);
    }
  }
}

final List<String> imgList = ['assets/images/capture.png'];
