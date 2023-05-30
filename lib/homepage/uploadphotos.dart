import 'package:flutter/material.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({Key? key}) : super(key: key);

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
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
          'Upload Photos',
          style: TextStyle(
              fontSize: 18,
              color: Color(0xffFFC107),
              fontFamily: 'NotoSansTaiTham',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.6,right: 16.95),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Container(
                height: 47.26,
                width: 339.46,
                decoration: const BoxDecoration(
                  color:Color(0xffFFC107),
                  borderRadius: BorderRadius.all(Radius.circular(5),)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.14,top: 15,bottom: 12),
                  child: Row(
                    children: [
                      Image.asset('assets/circleimage/upload.png'),
                      // ignore: prefer_const_constructors
                      SizedBox(width: 23.41,),
                      // ignore: prefer_const_constructors
                      Text('Upload Logo',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'NotoSansTaiTham',color: Colors.white),)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25,bottom: 30),
              child: Container(
                height: 47.26,
                width: 339.46,
                decoration: const BoxDecoration(
                  color:Color(0xffFFC107),
                  borderRadius: BorderRadius.all(Radius.circular(5),)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.14,top: 15,bottom: 12),
                  child: Row(
                    children: [
                      Image.asset('assets/circleimage/upload.png'),
                      // ignore: prefer_const_constructors
                      SizedBox(width: 23.41,),
                      // ignore: prefer_const_constructors
                      Text('Upload Cover Photo',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'NotoSansTaiTham',color: Colors.white),)
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //                Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const Bottomnavigation()),
                // );
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
      ),
);
  }
}