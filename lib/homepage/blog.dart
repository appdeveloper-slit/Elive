import 'package:elive/allstatic/colors.dart';
import 'package:elive/allstatic/dimens.dart';
import 'package:elive/allstatic/static_method.dart';
import 'package:elive/allstatic/styles.dart';
import 'package:elive/allstatic/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class BlogPage extends StatefulWidget {
  final dynamic blogview;

  const BlogPage(this.blogview, {Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Clr().black,
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
        title: Container(
          height: Dim().d52,
          child: Marquee(
            text: '${widget.blogview['title'].toString()}',
            style: const TextStyle(
                fontSize: 18,
                color: Color(0xffFFC107),
                fontFamily: 'NotoSansTaiTham',
                fontWeight: FontWeight.w600),
            scrollAxis: Axis.horizontal,
            startPadding: 30.0,
            blankSpace: 10.0,
            velocity: 50.0,
            pauseAfterRound: Duration(seconds: 1),
            accelerationDuration: Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        )
        // Text(
        //   '${widget.blogview['title'].toString()}',
        //   style: const TextStyle(
        //       fontSize: 18,
        //       color: Color(0xffFFC107),
        //       fontFamily: 'NotoSansTaiTham',
        //       fontWeight: FontWeight.w600),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dim().d16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d16),
              child: Container(
                height: Dim().d280,
                width: MediaQuery.of(ctx).size.width,
                decoration: BoxDecoration(
                    color: Color(0xff333741),
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://sonibro.com/elive/${widget.blogview['img_path'].toString()}'),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(
              height: Dim().d28,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d16),
              child: Text(
                widget.blogview['description'].toString(),
                style: Sty().mediumText.copyWith(color: Clr().white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
