
import 'package:flutter/material.dart';
import '../homepage/mainhomepage.dart';
import '../homepage/profile.dart';
import '../homepage/servicespage.dart';
import 'colors.dart';
import 'static_method.dart';

Widget bottomBarLayout(ctx, index) {
  return BottomNavigationBar(
    backgroundColor: Clr().primaryColor,
    selectedItemColor: Clr().golden,
    unselectedItemColor: Clr().grey38,
    type: BottomNavigationBarType.fixed,
    currentIndex: index,
    onTap: (index) async {
      switch (index) {
        case 0:
          STM.finishAffinity(ctx, MainHomePage());
          break;
        case 1:
          STM.redirect2page(ctx, const Servicespage());
          break;
        case 2 :
          STM.redirect2page(ctx, const Profilepage());
          break;
      }
    },
    items: STM.getBottomList(index),
  );
}
