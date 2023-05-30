import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UploadDocument extends StatefulWidget {
  const UploadDocument({Key? key}) : super(key: key);

  @override
  State<UploadDocument> createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
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
          'Upload Documents',
          style: TextStyle(
              fontSize: 18,
              color: Color(0xffFFC107),
              fontFamily: 'NotoSansTaiTham',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.6, top: 24.17,),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: const EdgeInsets.only(top: 10,bottom: 20),
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
                        'Upload Pan Card Photos',
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
             const Text(
              'GST Number (Optional)',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffFFC107),
                  fontFamily: 'NotoSansTaiTham'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 20),
              child: Container(
                height: 47.26,
                width: 339.46,
                decoration: const BoxDecoration(
                    color: Color(0xff333741),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    )),
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 22.14, top: 15, bottom: 12),
                  child: Text(
                    'Enter GST Number',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'NotoSansTaiTham',
                        color: Colors.white),
                  ),
                ),
              ),
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
              padding: const EdgeInsets.only(top: 10,bottom: 30),
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
                        'Upload GST Certificates',
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
            Padding(
              padding: const EdgeInsets.only(right:23),
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
        ),
      ),
    );
  }
}
