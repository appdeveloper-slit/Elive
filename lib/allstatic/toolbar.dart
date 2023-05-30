import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'colors.dart';
import 'dimens.dart';
import 'static_method.dart';
import 'styles.dart';

PreferredSizeWidget toolbar1Layout(title, ctx) {
  return AppBar(
    backgroundColor: Color(0xff333741),
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: Sty().mediumBoldText.copyWith(
            color: Color(0xffe0a906),
            fontSize: 20,
            fontFamily: 'Poppins',
          ),
    ),
    leading: Padding(
      padding: EdgeInsets.all(
        Dim().d20,
      ),
      child: InkWell(
          onTap: () {
            STM.back2Previous(ctx);
          },
          child: Icon(
            Icons.arrow_back,
            color: Clr().black,
          )
          // Image.asset(
          //   'assets/arrow-left.png',
          //   color: Colors.black,
          //   height: Dim().d100,
          // ),
          ),
    ),
  );
}

PreferredSizeWidget bottomToolbarLayout(title, ctx) {
  return AppBar(
    backgroundColor: Clr().white,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: Sty().mediumBoldText.copyWith(
        color: Clr().colorblue,
        fontSize: 20,
        fontFamily: 'Poppins',
      ),
    ),
    leading: Padding(
      padding: EdgeInsets.all(
        Dim().d20,
      ),
      child: InkWell(
          onTap: () {
            // STM.replacePage(ctx,const Home());
          },
          child: Icon(
            Icons.arrow_back,
            color: Clr().black,
          )
        // Image.asset(
        //   'assets/arrow-left.png',
        //   color: Colors.black,
        //   height: Dim().d100,
        // ),
      ),
    ),
  );
}

PreferredSizeWidget toolbar3Layout(ctx, scaffoldKey) {
  return AppBar(
      backgroundColor: Clr().white,
      elevation: 0,
      centerTitle: true,
      title: Image.asset(
        'assets/homeimage.png',
        height: Dim().d36,
      ),
      // ),
      leading: IconButton(
        onPressed: () => scaffoldKey.currentState!.openDrawer(),
        icon: Padding(
          padding: EdgeInsets.all(Dim().d8),
          child: Image.asset(
            'assets/menu.png',
            color: Clr().colorblue,
            height: Dim().d140,
          ),
        ),
      ));
}

PreferredSizeWidget toolbar2Layout(ctx, scaffoldKey) {
  return AppBar(
    toolbarHeight: Dim().d60,
    backgroundColor: Color(0xff2D61B6),
    leading: IconButton(
      padding: const EdgeInsets.only(
        left: 12,
      ),
      icon: SvgPicture.asset(
        'assets/menu.svg',
        height: Dim().d20,
        color: Clr().white,
      ),
      onPressed: () => scaffoldKey.currentState!.openDrawer(),
    ),
    centerTitle: true,
    title: Text(
      'Studyleague IT Solut ...',
      style: Sty().largeText.copyWith(
            color: Clr().white,
          ),
    ),
    actions: [
      Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: Image.asset(
                'assets/signin/notification.png',
                height: Dim().d40,
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {

          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(
          //       right: 20,
          //     ),
          //     child: SvgPicture.asset(
          //       'assets/cart.svg',
          //       height: Dim().d20,
          //     ),
          //   ),
          // ),
        ],
      ),
    ],
  );
}

PreferredSizeWidget toolbar5Layout(title) {
  return AppBar(
    backgroundColor: Clr().primaryColor,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: Sty().mediumText.copyWith(
            color: Clr().white,
            fontSize: 20,
          ),
    ),
    leading: Padding(
      padding: EdgeInsets.all(
        Dim().d20,
      ),
      child: SvgPicture.asset(
        'assets/back.svg',
        color: Clr().white,
      ),
    ),
  );
}
