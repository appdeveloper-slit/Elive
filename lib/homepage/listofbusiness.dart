import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:elive/allstatic/dimens.dart';
import 'package:elive/allstatic/strings.dart';
import 'package:elive/fullimage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../allstatic/colors.dart';
import '../allstatic/static_method.dart';
import '../allstatic/styles.dart';
import 'mainhomepage.dart';

class Listofbuisness extends StatefulWidget {
  final String? SCategoryid;
  final page;

  const Listofbuisness({
    Key? key,
    this.SCategoryid,
    this.page,
  }) : super(key: key);

  @override
  State<Listofbuisness> createState() => _ListofbuisnessState();
}

class _ListofbuisnessState extends State<Listofbuisness> {
  TimeOfDay timebefore = TimeOfDay(hour: 12, minute: 00);
  TimeOfDay timeafter = TimeOfDay(hour: 12, minute: 00);

  ///// imagelist
  List<dynamic> coverimagelist = [];
  String? logoImage, sPanCardlogo, sgstCertficate;

  int pageNumber = 0;
  late BuildContext ctx;
  List<dynamic> stateList = [];
  List<dynamic> citylist = [];
  DateTime _dateTime = DateTime.now();

  // BusinessDetails
  TextEditingController busnamectrl = TextEditingController();
  TextEditingController busemailctrl = TextEditingController();
  TextEditingController busmobilectrl = TextEditingController();
  String? TimeAm;
  String? TimePm;
  String? business_id;

  // Add Address
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  TextEditingController addpincodectrl = TextEditingController();
  TextEditingController addLandMarkctrl = TextEditingController();
  TextEditingController addAddressctrl = TextEditingController();
  String? statevalue;
  String? cityvalue;
  bool? pancardvalue;

  // Upload Photos
  List<String> base64List = [];
  String? sGstPhoto;
  String? sPanPhoto;
  String? sUplodLogo;

  // Upload Documnets
  TextEditingController gstctrl = TextEditingController();

  // keys
  final _businesskey = GlobalKey<FormState>();
  final _addresskey = GlobalKey<FormState>();
  String? _userid;

  getSessionData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _userid = sp.getString("user_id") ?? "";
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        checkGps();
        widget.page ?? getBusinessDetails();
        states();
      }
    });
  }

  @override
  void initState() {
    getSessionData();
    setState(() {
      widget.page != null ? pageNumber = widget.page : pageNumber = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    widget.page != null ? TimeAm = timebefore.format(context) : null;
    widget.page != null ? TimePm = timeafter.format(context) : null;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xff333741),
        leading: GestureDetector(
          onTap: () {
            if (pageNumber > 0) {
              setState(() {
                pageNumber--;
              });
            } else {
              Navigator.pop(ctx);
            }
          },
          // ignore: prefer_const_constructors
          child: Icon(
            Icons.arrow_back_ios,
            color: const Color(0xffffc107),
          ),
        ),
        centerTitle: true,
        title: Text(
          pageNumber == 0
              ? 'List Your Business'
              : pageNumber == 1
                  ? 'Business Details'
                  : pageNumber == 2
                      ? 'Add Address'
                      : pageNumber == 3
                          ? 'Upload Photos'
                          : pageNumber == 4
                              ? 'Upload Documents'
                              : 'List Your Business',
          style: TextStyle(
              fontSize: 18,
              color: Color(0xffFFC107),
              fontFamily: 'NotoSansTaiTham',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          STM.back2Previous(ctx);
          return false;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              if (pageNumber == 0) AllListBuisnesslayout(),
              if (pageNumber == 1) BuisnessDetailslayout(),
              if (pageNumber == 2) AddAdresslayout(),
              if (pageNumber == 3) UploadPhotoslayout(),
              if (pageNumber == 4) UploadDocumentslayout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget AllListBuisnesslayout() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 1;
              print(_userid);
            });
          },
          child: Container(
              child: Padding(
            padding: const EdgeInsets.only(top: 25, left: 12, right: 12),
            child: Container(
              height: 59.15,
              width: 340.01,
              decoration: const BoxDecoration(
                  color: Color(0xff333741),
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 17.08,
                      bottom: 17.08,
                      left: 21.48,
                    ),
                    child: Text(
                      'Business Deatils',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: 'NotoSansTaiTham'),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.only(right: 23.58),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xffFFC107),
                    ),
                  )
                ],
              ),
            ),
          )),
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 2;
            });
          },
          child: Container(
              child: Padding(
            padding: const EdgeInsets.only(top: 25, left: 12, right: 12),
            child: Container(
              height: 59.15,
              width: 340.01,
              decoration: const BoxDecoration(
                  color: Color(0xff333741),
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 17.08,
                      bottom: 17.08,
                      left: 21.48,
                    ),
                    child: Text(
                      'Add Address',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: 'NotoSansTaiTham'),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.only(right: 23.58),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xffFFC107),
                    ),
                  )
                ],
              ),
            ),
          )),
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 3;
            });
          },
          child: Container(
              child: Padding(
            padding: const EdgeInsets.only(top: 25, left: 12, right: 12),
            child: Container(
              height: 59.15,
              width: 340.01,
              decoration: const BoxDecoration(
                  color: Color(0xff333741),
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 17.08,
                      bottom: 17.08,
                      left: 21.48,
                    ),
                    child: Text(
                      'Upload Photos',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: 'NotoSansTaiTham'),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.only(right: 23.58),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xffFFC107),
                    ),
                  )
                ],
              ),
            ),
          )),
        ),
        InkWell(
          onTap: () {
            setState(() {
              pageNumber = 4;
            });
          },
          child: Container(
              child: Padding(
            padding: const EdgeInsets.only(top: 25, left: 12, right: 12),
            child: Container(
              height: 59.15,
              width: 340.01,
              decoration: const BoxDecoration(
                  color: Color(0xff333741),
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 17.08,
                      bottom: 17.08,
                      left: 21.48,
                    ),
                    child: Text(
                      'Upload Documents',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: 'NotoSansTaiTham'),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.only(right: 23.58),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xffFFC107),
                    ),
                  )
                ],
              ),
            ),
          )),
        ),
      ],
    );
  }

  Widget BuisnessDetailslayout() {
    return Form(
      key: _businesskey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: Dim().d20,
              bottom: Dim().d8,
            ),
            child: Text(
              'Business Name',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffFFC107),
                  fontFamily: 'NotoSansTaiTham'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dim().d4),
            child: TextFormField(
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'NotoSansTaiTham',
                  color: Colors.white),
              controller: busnamectrl,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This Field is Required';
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Clr().primaryColor,
                contentPadding: EdgeInsets.symmetric(
                    vertical: Dim().d12, horizontal: Dim().d12),
                enabledBorder: Sty().textFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().textFieldOutlineStyle.focusedBorder,
                disabledBorder: Sty().textFieldOutlineStyle.disabledBorder,
                focusedErrorBorder:
                    Sty().textFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().textFieldOutlineStyle.errorBorder,
                border: InputBorder.none,
                hintText: 'Enter Business Name ',
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NotoSansTaiTham',
                    color: Color.fromARGB(255, 209, 209, 209)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Dim().d20,
              bottom: Dim().d8,
            ),
            child: Text(
              'Business Email Addeess',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffFFC107),
                  fontFamily: 'NotoSansTaiTham'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dim().d4,
            ),
            child: TextFormField(
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'NotoSansTaiTham',
                  color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return "Please enter a valid email address";
                }
                return null;
              },
              controller: busemailctrl,
              decoration: InputDecoration(
                filled: true,
                fillColor: Clr().primaryColor,
                contentPadding: EdgeInsets.symmetric(
                    vertical: Dim().d12, horizontal: Dim().d12),
                enabledBorder: Sty().textFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().textFieldOutlineStyle.focusedBorder,
                disabledBorder: Sty().textFieldOutlineStyle.disabledBorder,
                focusedErrorBorder:
                    Sty().textFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().textFieldOutlineStyle.errorBorder,
                border: InputBorder.none,
                hintText: 'Enter The Email Id',
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NotoSansTaiTham',
                    color: Color.fromARGB(255, 209, 209, 209)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Dim().d20,
              bottom: Dim().d8,
            ),
            child: Text(
              'Mobile Number',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffFFC107),
                  fontFamily: 'NotoSansTaiTham'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dim().d4),
            child: TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'NotoSansTaiTham',
                  color: Colors.white),
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
              controller: busmobilectrl,
              decoration: InputDecoration(
                filled: true,
                counterText: '',
                fillColor: Clr().primaryColor,
                contentPadding: EdgeInsets.symmetric(
                    vertical: Dim().d12, horizontal: Dim().d12),
                enabledBorder: Sty().textFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().textFieldOutlineStyle.focusedBorder,
                disabledBorder: Sty().textFieldOutlineStyle.disabledBorder,
                focusedErrorBorder:
                    Sty().textFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().textFieldOutlineStyle.errorBorder,
                border: InputBorder.none,
                hintText: 'Enter Mobile Number',
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NotoSansTaiTham',
                    color: Color.fromARGB(255, 209, 209, 209)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Dim().d20,
              bottom: Dim().d8,
            ),
            child: Text(
              'Office Time',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffFFC107),
                  fontFamily: 'NotoSansTaiTham'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    TimeOfDay? newtime = await showTimePicker(
                        context: ctx, initialTime: timebefore);
                    if (newtime == null) return;
                    setState(() => timebefore = newtime);
                    setState(() => TimeAm = timebefore.format(context));
                  },
                  child: Container(
                    height: 50,
                    width: 155,
                    decoration: BoxDecoration(
                        color: Color(0xff333741),
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 13.41,
                              top: 14.92,
                              bottom: 15.08,
                              right: 21.26),
                          child: Image.asset(
                            'assets/images/watch.png',
                            height: 20,
                            width: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            // '${timebefore.format(context)}',
                            '$TimeAm',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: 'NotoSansTaiTham'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.01, right: 6.05),
                  child: Text(
                    'to',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'NotoSansTaiTham'),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    TimeOfDay? newtimeafter = await showTimePicker(
                        context: ctx, initialTime: timeafter);
                    if (newtimeafter == null) return;
                    setState(() => timeafter = newtimeafter);
                    setState(() => TimePm = timeafter.format(context));
                  },
                  child: Container(
                    height: 50,
                    width: 155,
                    decoration: BoxDecoration(
                        color: Color(0xff333741),
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 13.41,
                              top: 14.92,
                              bottom: 15.08,
                              right: 21.26),
                          child: Image.asset(
                            'assets/images/watch.png',
                            height: 20,
                            width: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            // '${timeafter.format(context)}',
                            '$TimePm',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: 'NotoSansTaiTham'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 16.5,
            ),
            child: GestureDetector(
              onTap: () {
                if (_businesskey.currentState!.validate()) {
                  BusinessDetails();
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Color(0xffffc107),
                ),
                child: const Center(
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'NotoSansTaiTham',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget AddAdresslayout() {
    return Form(
      key: _addresskey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                getLocation();
              });
            },
            child: Column(children: [
              Row(
                children: [
                  Image.asset(
                    'assets/circleimage/navigate.png',
                    height: 18,
                    width: 18,
                  ),
                  const SizedBox(
                    width: 14.08,
                  ),
                  Text(
                    'Use my current location',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'NotoSansTaiTham',
                        color: Color(0xffFFC107)),
                  ),
                ],
              ),
              SizedBox(
                height: Dim().d12,
              ),
              Row(
                children: [
                  Text("Longitude: $long",
                      style:
                          TextStyle(fontSize: Dim().d12, color: Clr().white)),
                  SizedBox(width: Dim().d12),
                  Text("Latitude: $lat",
                      style: TextStyle(fontSize: Dim().d12, color: Clr().white))
                ],
              ),
            ]),
          ),
          SizedBox(
            height: Dim().d16,
          ),
          const Divider(
            color: Color(0xff333741),
            thickness: 0.50,
          ),
          SizedBox(
            height: Dim().d16,
          ),
          Text(
            'State (Required)',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xffFFC107),
                fontFamily: 'NotoSansTaiTham'),
          ),
          SizedBox(
            height: Dim().d8,
          ),
          Container(
            height: 50,
            width: 340.01,
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                color: Color(0xff333741)),
            child: DropdownButton(
                dropdownColor: Color(0xff333741),
                isDense: true,
                isExpanded: true,
                hint: Text(statevalue ?? 'Select The State',
                    style: Sty().mediumText.copyWith(color: Clr().white)),
                style: TextStyle(color: Clr().white),
                underline: Container(),
                items: stateList.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value['name'],
                    child: Text(
                      value['name'],
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: 'NotoSansTaiTham'),
                    ),
                  );
                }).toList(),
                value: statevalue,
                icon: Image.asset(
                  'assets/circleimage/downpath.png',
                  height: 12,
                ),
                onChanged: (ss) {
                  setState(() {
                    statevalue = ss as String;
                    cityvalue = null;
                    int position = stateList.indexWhere((e) => e['name'] == ss.toString());
                    citylist = stateList[position]['city'];
                  });
                }),
          ),
          SizedBox(
            height: Dim().d4,
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Text(
            'City (Required)',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xffFFC107),
                fontFamily: 'NotoSansTaiTham'),
          ),
          SizedBox(
            height: Dim().d8,
          ),
          InkWell(onTap: (){
            citylist.isEmpty ? STM.displayToast('Please select state') : null;
          },
            child: Container(
              height: 50,
              width: 340.01,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color: Color(0xff333741)),
              padding: const EdgeInsets.all(10),
              child: DropdownButton(
                  dropdownColor: const Color(0xff333741),
                  isDense: true,
                  isExpanded: true,
                  hint: Text(
                    cityvalue ?? 'Select The City',
                    style: Sty().mediumText.copyWith(color: Clr().white),
                  ),
                  underline: Container(),
                  items: citylist.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value['name'],
                      child: Text(
                        value['name'],
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontFamily: 'NotoSansTaiTham'),
                      ),
                    );
                  }).toList(),
                  value: cityvalue,
                  icon: Image.asset(
                    'assets/circleimage/downpath.png',
                    height: 12,
                  ),
                  onChanged: (ss) {
                    setState(() {
                      cityvalue = ss as String;
                    });
                  }),
            ),
          ),
          SizedBox(
            height: Dim().d4,
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Text(
            'Pincode (Required)',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xffFFC107),
                fontFamily: 'NotoSansTaiTham'),
          ),
          SizedBox(
            height: Dim().d8,
          ),
          Padding(
            padding: EdgeInsets.only(right: Dim().d12),
            child: TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 6,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'NotoSansTaiTham',
                  color: Colors.white),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field is required';
                }
                if (value.length != 6) {
                  return 'Pincode digits must be 6';
                }
              },
              controller: addpincodectrl,
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: Clr().primaryColor,
                contentPadding: EdgeInsets.symmetric(
                    vertical: Dim().d12, horizontal: Dim().d12),
                enabledBorder: Sty().textFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().textFieldOutlineStyle.focusedBorder,
                disabledBorder: Sty().textFieldOutlineStyle.disabledBorder,
                focusedErrorBorder:
                    Sty().textFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().textFieldOutlineStyle.errorBorder,
                border: InputBorder.none,
                hintText: 'Pincode',
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NotoSansTaiTham',
                    color: Color.fromARGB(255, 209, 209, 209)),
              ),
            ),
          ),
          SizedBox(
            height: Dim().d4,
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Text(
            'Land Mark',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xffFFC107),
                fontFamily: 'NotoSansTaiTham'),
          ),
          SizedBox(
            height: Dim().d8,
          ),
          Padding(
            padding: EdgeInsets.only(right: Dim().d12),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'NotoSansTaiTham',
                  color: Colors.white),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field is required';
                }
              },
              controller: addLandMarkctrl,
              decoration: InputDecoration(
                filled: true,
                fillColor: Clr().primaryColor,
                contentPadding: EdgeInsets.symmetric(
                    vertical: Dim().d12, horizontal: Dim().d12),
                enabledBorder: Sty().textFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().textFieldOutlineStyle.focusedBorder,
                disabledBorder: Sty().textFieldOutlineStyle.disabledBorder,
                focusedErrorBorder:
                    Sty().textFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().textFieldOutlineStyle.errorBorder,
                border: InputBorder.none,
                hintText: 'Land Mark',
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NotoSansTaiTham',
                    color: Color.fromARGB(255, 209, 209, 209)),
              ),
            ),
          ),
          SizedBox(
            height: Dim().d20,
          ),
          Text(
            'Shop No/House No/Building Name',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xffFFC107),
                fontFamily: 'NotoSansTaiTham'),
          ),
          SizedBox(
            height: Dim().d8,
          ),
          Padding(
            padding: EdgeInsets.only(right: Dim().d12),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'NotoSansTaiTham',
                  color: Colors.white),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field is required';
                }
              },
              controller: addAddressctrl,
              decoration: InputDecoration(
                filled: true,
                fillColor: Clr().primaryColor,
                contentPadding: EdgeInsets.symmetric(
                    vertical: Dim().d12, horizontal: Dim().d12),
                enabledBorder: Sty().textFieldOutlineStyle.enabledBorder,
                focusedBorder: Sty().textFieldOutlineStyle.focusedBorder,
                disabledBorder: Sty().textFieldOutlineStyle.disabledBorder,
                focusedErrorBorder:
                    Sty().textFieldOutlineStyle.focusedErrorBorder,
                errorBorder: Sty().textFieldOutlineStyle.errorBorder,
                border: InputBorder.none,
                hintText: 'Address',
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NotoSansTaiTham',
                    color: Color.fromARGB(255, 209, 209, 209)),
              ),
            ),
          ),
          SizedBox(
            height: Dim().d28,
          ),
          GestureDetector(
            onTap: () {
              if (_addresskey.currentState!.validate()) {
                Addadress();
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: const Color(0xffffc107),
              ),
              child: const Center(
                child: Text(
                  'SAVE',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'NotoSansTaiTham',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget UploadPhotoslayout() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dim().d20,
          ),
          InkWell(
            onTap: () {
              filePicker('logo', false);
            },
            child: Container(
              height: 47.26,
              width: 339.46,
              decoration: const BoxDecoration(
                  color: Color(0xffFFC107),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 22.14, top: 15, bottom: 12),
                child: Row(
                  children: [
                    Image.asset('assets/circleimage/upload.png'),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      width: 23.41,
                    ),
                    // ignore: prefer_const_constructors
                    Text(
                      sUplodLogo != null ? 'Image Selected' : 'Upload Logo',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'NotoSansTaiTham',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: Dim().d12,
          ),
          logoImage == null
              ? Container()
              : Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: Dim().d4,
                      ),
                      child: InkWell(
                        onTap: () {
                          STM.redirect2page(
                              ctx,
                              FullImage(
                                  'https://sonibro.com/elive/${logoImage}'));
                        },
                        child: Container(
                          height: Dim().d100,
                          width: Dim().d120,
                          decoration: BoxDecoration(
                              border: Border.all(color: Clr().black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(Dim().d12),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://sonibro.com/elive/${logoImage}'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                    // Positioned(
                    //     top: 10,
                    //     right: 14,
                    //     child: InkWell(
                    //       onTap: () {
                    //
                    //       },
                    //       child: SvgPicture.asset(
                    //         'assets/cut.svg',
                    //         height: Dim().d20,
                    //         width: Dim().d20,
                    //       ),
                    //     )),
                  ],
                ),
          SizedBox(
            height: Dim().d20,
          ),
          InkWell(
            onTap: () {
              multiplefilepicker();
            },
            child: Container(
              height: 47.26,
              width: 339.46,
              decoration: const BoxDecoration(
                  color: Color(0xffFFC107),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 22.14, top: 15, bottom: 12),
                child: Row(
                  children: [
                    Image.asset('assets/circleimage/upload.png'),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      width: 23.41,
                    ),
                    // ignore: prefer_const_constructors
                    Text(
                      base64List.length > 0
                          ? 'Images Selected'
                          : 'Upload Cover Photo',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'NotoSansTaiTham',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: Dim().d12,
          ),
          coverimagelist.isEmpty
              ? Container()
              : GridView.builder(
                  itemCount: coverimagelist.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: Dim().d4,
                          ),
                          child: InkWell(
                            onTap: () {
                              STM.redirect2page(
                                  ctx,
                                  FullImage(
                                      'https://sonibro.com/elive/${coverimagelist[index]['image_path'].toString()}'));
                            },
                            child: Container(
                              width: Dim().d140,
                              height: Dim().d140,
                              margin: EdgeInsets.only(bottom: Dim().d8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Clr().black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(Dim().d12),
                                  )),
                              child: Image.network(
                                'https://sonibro.com/elive/${coverimagelist[index]['image_path'].toString()}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 10,
                            right: 14,
                            child: InkWell(
                              onTap: () {
                                removeimage(
                                    coverimagelist[index]['id'].toString(),
                                    coverimagelist[index].toString());
                              },
                              child: SvgPicture.asset(
                                'assets/cut.svg',
                                height: Dim().d20,
                                width: Dim().d20,
                              ),
                            )),
                      ],
                    );
                  }),
          SizedBox(
            height: Dim().d20,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                uploadphoto();
              });
            },
            child: Container(
              height: 50,
              width: 339.46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: const Color(0xffffc107),
              ),
              child: const Center(
                child: Text(
                  'SAVE',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'NotoSansTaiTham',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget UploadDocumentslayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Text(
          'Pan Card',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffFFC107),
              fontFamily: 'NotoSansTaiTham'),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dim().d8, bottom: Dim().d20),
          child: InkWell(
            onTap: () {
              filePicker('Pan', false);
            },
            child: Container(
              height: 47.26,
              width: 339.46,
              decoration: const BoxDecoration(
                  color: Color(0xffFFC107),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 22.14, top: 15, bottom: 12),
                child: Row(
                  children: [
                    Image.asset('assets/circleimage/upload.png'),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      width: 23.41,
                    ),
                    // ignore: prefer_const_constructors
                    Text(
                      sPanPhoto != null
                          ? 'Image Is Selected'
                          : 'Upload Pan Card Photos',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'NotoSansTaiTham',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        sPanCardlogo == null
            ? Container()
            : Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: Dim().d4,
                    ),
                    child: InkWell(
                      onTap: () {
                        STM.redirect2page(
                            ctx,
                            FullImage(
                                'https://sonibro.com/elive/${sPanCardlogo}'));
                      },
                      child: Container(
                        height: Dim().d100,
                        width: Dim().d120,
                        decoration: BoxDecoration(
                            border: Border.all(color: Clr().black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dim().d12),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://sonibro.com/elive/${sPanCardlogo}'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  // Positioned(
                  //     top: 10,
                  //     right: 14,
                  //     child: InkWell(
                  //       onTap: () {
                  //
                  //       },
                  //       child: SvgPicture.asset(
                  //         'assets/cut.svg',
                  //         height: Dim().d20,
                  //         width: Dim().d20,
                  //       ),
                  //     )),
                ],
              ),
        pancardvalue == true
            ? Text(
                'Pancard image is required',
                style: Sty().mediumText.copyWith(color: Clr().errorRed),
              )
            : Container(),
        SizedBox(
          height: Dim().d12,
        ),
        const Text(
          'GST Number (Optional)',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffFFC107),
              fontFamily: 'NotoSansTaiTham'),
        ),
        SizedBox(
          height: Dim().d8,
        ),
        Padding(
          padding: EdgeInsets.only(right: Dim().d12),
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'NotoSansTaiTham',
                color: Colors.white),
            validator: (value) {
              if (value!.isEmpty) {
                return 'This field is required';
              }
            },
            controller: gstctrl,
            maxLength: 15,
            decoration: InputDecoration(
              filled: true,
              counterText: '',
              fillColor: Clr().primaryColor,
              contentPadding: EdgeInsets.symmetric(
                  vertical: Dim().d12, horizontal: Dim().d12),
              enabledBorder: Sty().textFieldOutlineStyle.enabledBorder,
              focusedBorder: Sty().textFieldOutlineStyle.focusedBorder,
              disabledBorder: Sty().textFieldOutlineStyle.disabledBorder,
              focusedErrorBorder:
                  Sty().textFieldOutlineStyle.focusedErrorBorder,
              errorBorder: Sty().textFieldOutlineStyle.errorBorder,
              border: InputBorder.none,
              hintText: 'Enter GST Number',
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'NotoSansTaiTham',
                  color: Color.fromARGB(255, 209, 209, 209)),
            ),
          ),
        ),
        SizedBox(
          height: Dim().d20,
        ),
        const Text(
          'GST Certificates (Optional)',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffFFC107),
              fontFamily: 'NotoSansTaiTham'),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dim().d8, bottom: 30),
          child: InkWell(
            onTap: () {
              filePicker('Gst', false);
            },
            child: Container(
              height: 47.26,
              width: 339.46,
              decoration: const BoxDecoration(
                  color: Color(0xffFFC107),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 22.14, top: 15, bottom: 12),
                child: Row(
                  children: [
                    Image.asset('assets/circleimage/upload.png'),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      width: 23.41,
                    ),
                    // ignore: prefer_const_constructors
                    Text(
                      sGstPhoto != null
                          ? 'Image Selected'
                          : 'Upload GST Certificates',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'NotoSansTaiTham',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        sgstCertficate == null
            ? Container()
            : Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: Dim().d4,
                    ),
                    child: InkWell(
                      onTap: () {
                        STM.redirect2page(
                            ctx,
                            FullImage(
                                'https://sonibro.com/elive/${sgstCertficate}'));
                      },
                      child: Container(
                        height: Dim().d100,
                        width: Dim().d120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Clr().black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dim().d12),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://sonibro.com/elive/${sgstCertficate}'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //     top: 10,
                  //     right: 14,
                  //     child: InkWell(
                  //       onTap: () {
                  //
                  //       },
                  //       child: SvgPicture.asset(
                  //         'assets/cut.svg',
                  //         height: Dim().d20,
                  //         width: Dim().d20,
                  //       ),
                  //     )),
                ],
              ),
        SizedBox(
          height: Dim().d12,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 23),
          child: GestureDetector(
            onTap: () {
              if (sPanPhoto == null && sPanCardlogo == null) {
                setState(() {
                  pancardvalue = true;
                });
              } else {
                uploaddocuments();
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: const Color(0xffffc107),
              ),
              child: const Center(
                child: Text(
                  'SAVE AND SUBMIT',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'NotoSansTaiTham',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Pick Image
  void filePicker(type, userWantsCamera) async {
    bool isCamera = userWantsCamera;
    FilePickerResult? result;
    ImagePicker _picker = ImagePicker();
    XFile? photo;
    if (isCamera == true) {
      photo = await _picker.pickImage(source: ImageSource.camera);
    } else {
      result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg']);
    }
    final image;
    if (result != null || photo != null) {
      if (isCamera == true) {
        image = await photo!.readAsBytes();
      } else {
        image = File(result!.files.single.path.toString()).readAsBytesSync();
      }
      setState(() {
        switch (type) {
          case "logo":
            sUplodLogo = base64Encode(image);
            break;
          case "Pan":
            sPanPhoto = base64Encode(image);
            break;
          case "Gst":
            sGstPhoto = base64Encode(image);
            break;
        }
        print(sUplodLogo);
      });
    }
  }

  // Multipleimage
  void multiplefilepicker() async {
    base64List.clear();
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      List<File> imagelist = result.paths.map((path) => File(path!)).toList();
      var image;
      for (var a = 0; a < imagelist.length; a++) {
        setState(() {
          image = imagelist[a].readAsBytesSync();
          base64List.add(base64Encode(image).toString());
        });
      }
      print(base64List);
    }
  }

  // check gps
  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }
      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  //get location
  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457
    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }

  void BusinessDetails() async {
    FormData body = FormData.fromMap({
      "business_name": busnamectrl.text,
      "business_email": busemailctrl.text,
      "business_mobile": busmobilectrl.text,
      "business_office_time_from": TimeAm,
      "business_office_time_to": TimePm,
      "category_id": widget.SCategoryid,
      "user_id": _userid
    });
    var result = widget.page != null
        ? await STM().post(ctx, Str().processing, 'businessDetails', body)
        : await STM().post(ctx, Str().updating, 'update_business', body);
    var success = result['success'];
    var message = result['message'];
    var error = result['error'];
    if (success) {
      setState(() {
        widget.page != null
            ? business_id = result['business_details']['id'].toString()
            : business_id = result['business_id'].toString();
        STM.displayToast(message);
        pageNumber++;
      });
    } else {
      STM.errorDialog(ctx, message);
    }
  }

  void Addadress() async {
    FormData body = FormData.fromMap({
      "state": statevalue,
      "city": cityvalue,
      "pincode": addpincodectrl.text,
      "land_mark": addLandMarkctrl.text,
      "shop_number": addAddressctrl.text,
      "longitude": long,
      "latitude": lat,
      "user_id": _userid
    });
    var result = await STM().post(ctx, Str().processing, 'addAddress', body);
    var success = result['success'];
    var message = result['message'];
    var error = result['error'];
    if (success) {
      setState(() {
        STM.displayToast(message);
        pageNumber++;
      });
    } else {
      STM.errorDialog(ctx, message);
    }
  }

  void uploadphoto() async {
    FormData body = FormData.fromMap({
      "logo": sUplodLogo,
      "cover_image": json.encode(base64List),
      "user_id": _userid,
      "business_id": business_id,
    });
    var result = await STM().post(ctx, Str().processing, 'uploadPhotos', body);
    var success = result['success'];
    var message = result['message'];
    var error = result['error'];
    if (success) {
      setState(() {
        STM.displayToast(message);
        pageNumber++;
      });
    } else {
      STM.errorDialog(ctx, message);
    }
  }

  void uploaddocuments() async {
    FormData body = FormData.fromMap({
      "logo": sUplodLogo,
      "pan_card": sPanPhoto,
      "gst_number": gstctrl.text,
      "gst_certificate": sGstPhoto,
      "user_id": _userid,
    });
    var result =
        await STM().post(ctx, Str().processing, 'uploadDocuments', body);
    var success = result['success'];
    var message = result['message'];
    var error = result['error'];
    if (success) {
      setState(() {
        STM.displayToast(message);
        STM.successDialogWithAffinity(ctx, message, MainHomePage());
      });
    } else {
      STM.errorDialog(ctx, message);
    }
  }

  void getBusinessDetails() async {
    FormData body = FormData.fromMap({
      "user_id": _userid,
    });
    var result =
        await STM().post(ctx, Str().loading, 'get_user_business', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      setState(() {
        busnamectrl =
            TextEditingController(text: result['business']['business_name']);
        busemailctrl =
            TextEditingController(text: result['business']['business_email']);
        busmobilectrl = TextEditingController(
            text: result['business']['business_mobile'].toString());
        TimeAm = result['business']['business_office_time_to'];
        TimePm = result['business']['business_office_time_from'];
        statevalue = result['business']['state'];
        cityvalue = result['business']['city'];
        addpincodectrl =
            TextEditingController(text: result['business']['pincode']);
        addLandMarkctrl =
            TextEditingController(text: result['business']['land_mark']);
        addAddressctrl =
            TextEditingController(text: result['business']['shop_number']);
        gstctrl = TextEditingController(text: result['business']['gst_number']);
        coverimagelist = result['business']['image'];
        logoImage = result['business']['logo'];
        sgstCertficate = result['business']['gst_certificate'];
        sPanCardlogo = result['business']['pan_card'];
      });
    } else {}
  }

  void removeimage(imageid, index) async {
    FormData body = FormData.fromMap({
      'image_id': imageid,
    });
    var result = await STM().post(ctx, Str().loading, 'remove_image', body);
    var success = result['success'];
    var message = result['message'];
    if (success) {
      setState(() {
        coverimagelist.remove(index);
      });
      getBusinessDetails();
      STM.displayToast(message);
    } else {
      STM.errorDialog(ctx, message);
    }
  }

  void states() async {
    var result = await STM().get(ctx, 'get_cities');
    var success = result['success'];
    if(success){
      setState(() {
        stateList = result['cities'];
      });
    }
  }

}
