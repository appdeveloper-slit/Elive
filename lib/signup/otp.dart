// ignore_for_file: prefer_const_constructors

import 'package:elive/homepage/bottomnavigation.dart';
import 'package:elive/homepage/mainhomepage.dart';
import 'package:elive/signup/register.dart';
import 'package:flutter/material.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          height: 500,
          width: 900,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              SizedBox(
                  height: 32,
                  child: Text(
                    'Verification',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'NotoSansTaiTham'),
                  )),
              Text(
                "We've send you the verification ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'NotoSansTaiTham',
                  fontWeight: FontWeight.w100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90.02),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'code on ',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'NotoSansTaiTham'),
                    ),
                    // ignore: prefer_const_constructors
                    const Text(
                      ' +91 96325 87415',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.yellow,
                          fontFamily: 'NotoSansTaiTham'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 40.03, left: 18.9, right: 18.9, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: const Color.fromARGB(255, 58, 58, 58),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: const Color.fromARGB(255, 58, 58, 58),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: const Color.fromARGB(255, 58, 58, 58),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: const Color.fromARGB(255, 58, 58, 58),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // ignore: prefer_const_constructors

              // ignore: prefer_const_constructors
              TweenAnimationBuilder<Duration>(
                  duration: const Duration(seconds: 17),
                  tween: Tween(
                      begin: const Duration(seconds: 17), end: Duration.zero),
                  onEnd: () {
                    // ignore: avoid_print
                    // print('Timer ended');
                  },
                  builder:
                      (BuildContext context, Duration value, Widget? child) {
                    final minutes = value.inMinutes;
                    final seconds = value.inSeconds % 60;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        '$minutes:$seconds',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xffFFC107),
                            fontFamily: 'NotoSansTaiTham',
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 107.79, top: 3.26),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      "Didn't get it ?",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'NotoSansTaiTham'),
                    ),
                    const Text(
                      ' Resend OTP',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffffc107),
                          fontFamily: 'NotoSansTaiTham'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Bottomnavigation()),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Color(0xffffc107),
                    ),
                    child: const Center(
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'NotoSansTaiTham',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
