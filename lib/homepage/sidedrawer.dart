import 'package:elive/allstatic/dimens.dart';
import 'package:elive/allstatic/static_method.dart';
import 'package:elive/homepage/leadslist.dart';
import 'package:elive/homepage/listofbusiness.dart';
import 'package:elive/homepage/mainhomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../signup/signin.dart';
import 'category.dart';
import 'contactus.dart';
import 'profile.dart';

Widget navDrawer(context, key) {
  return SafeArea(
    child: WillPopScope(
      onWillPop: () async {
        if (key.currentState.isDrawerOpen) {
          key.currentState.openEndDrawer();
        }
        return true;
      },
      child: Drawer(
        width: 300,
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: Dim().d20,
          ),
          shrinkWrap: true,
          children: [
            SizedBox(
              height: Dim().d20,
            ),
            Image.asset(
              'assets/circleimage/sidedrawerlogo.png',
              height: 150,
            ),
            SizedBox(
              height: Dim().d20,
            ),
            GestureDetector(
              onTap: () {
                STM.finishAffinity(context, MainHomePage());
                close(key);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28.47),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/home.svg', height: 21),
                    SizedBox(
                      width: 26.43,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'NotoSansTaiTham',
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Categorylist()),
                );
                close(key);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28.47),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/listofbusiness.svg',
                        height: 21),
                    SizedBox(
                      width: 28.79,
                    ),
                    Text(
                      'List Your Business',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'NotoSansTaiTham',
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Categorylist()),
                // );
                STM.redirect2page(context, Listofbuisness());
                close(key);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28.47),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/listofbusiness.svg',
                        height: 21),
                    SizedBox(
                      width: 28.79,
                    ),
                    Text(
                      'My Business',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'NotoSansTaiTham',
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LeadsList()),
                );
                close(key);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28.47),
                child: Row(
                  children: [
                    Image.asset('assets/circleimage/leads.png', height: 21),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'My Leads',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'NotoSansTaiTham',
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28.47),
              child: InkWell(
                onTap: () {
                  STM.redirect2page(context, const Profilepage());
                  close(key);
                },
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/myprofile.svg', height: 21),
                    SizedBox(
                      width: 27.97,
                    ),
                    Text(
                      'My Profile',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'NotoSansTaiTham',
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            InkWell(onTap: () async {
              STM.openWeb('https://elive365.com/privacy_policy');
            },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28.47),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/Privacy Policy.svg',
                        height: 21),
                    SizedBox(
                      width: 26.87,
                    ),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'NotoSansTaiTham',
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            InkWell(onTap: (){
              STM.openWeb('https://elive365.com/terms_conditions');
            },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28.47),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/Terms & Conditions.svg',
                        height: 21),
                    SizedBox(
                      width: 28.81,
                    ),
                    Text(
                      'Terms & Conditions',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'NotoSansTaiTham',
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28.47),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/Share App.svg', height: 21),
                  SizedBox(
                    width: 26,
                  ),
                  Text(
                    'Share App',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'NotoSansTaiTham',
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28.47),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/About Us.svg', height: 21),
                  SizedBox(
                    width: 21.91,
                  ),
                  Text(
                    'About Us',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'NotoSansTaiTham',
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            InkWell(onTap: (){
              STM.redirect2page(context, ContactUs());
            },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28.47),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/Contact Us.svg', height: 21),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Contact Us',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'NotoSansTaiTham',
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setBool('is_login', false);
                sp.clear();
                STM.finishAffinity(context, Signup());
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28.47),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/logout.svg', height: 21),
                    SizedBox(
                      width: 23.06,
                    ),
                    Text(
                      'Log Out',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'NotoSansTaiTham',
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void close(key) {
  key.currentState.openEndDrawer();
}