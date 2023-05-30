// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BusinessDeatils extends StatefulWidget {
  const BusinessDeatils({Key? key}) : super(key: key);

  @override
  State<BusinessDeatils> createState() => _BusinessDeatilsState();
}

class _BusinessDeatilsState extends State<BusinessDeatils> {
  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Business Details',
          style: TextStyle(
              fontSize: 18,
              color: Color(0xffFFC107),
              fontFamily: 'NotoSansTaiTham',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  bottom: 10,
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
              Container(
                  height: 50,
                  width: 340.01,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      color: Color(0xff333741)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'NotoSansTaiTham',
                            color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Business name ',
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'NotoSansTaiTham',
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  bottom: 10,
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
              Container(
                height: 50,
                width: 340.01,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    color: Color(0xff333741)),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'NotoSansTaiTham',
                            color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'shivay123@gmail.com',
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'NotoSansTaiTham',
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  bottom: 10,
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
              Container(
                height: 50,
                width: 340.01,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    color: Color(0xff333741)),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'NotoSansTaiTham',
                            color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Mobile Number',
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'NotoSansTaiTham',
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  bottom: 10,
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
                    Container(
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
                              '9:00 am',
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
                    Container(
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
                              '9:00 am',
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 16.5,
                ),
                child: GestureDetector(
                  onTap: () {
                    //                Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const Bottomnavigation()),
                    // );
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
        ),
      ),
    );
  }
}
