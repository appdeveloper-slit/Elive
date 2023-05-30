import 'package:elive/allstatic/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../allstatic/dimens.dart';
import '../allstatic/styles.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Clr().black,
      appBar: AppBar(
        backgroundColor: Color(0xff333741),
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Clr().bgDrawer),
        title: Text(
          'Contact Us',
          style: Sty()
              .mediumText
              .copyWith(color: Clr().bgDrawer, fontSize: Dim().d24),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: Dim().d40),
          InkWell(onTap: () async{
            await launch('mailto: rahul.dhapatkar1010@gmail.com');
          },
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text('== Email ID ==',
                      style: Sty().mediumText.copyWith(color: Clr().bgDrawer)),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text('rahul.dhapatkar1010@gmail.com',
                        style: Sty().mediumText.copyWith(color: Clr().white)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
