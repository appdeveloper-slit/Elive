import 'package:elive/allstatic/dimens.dart';
import 'package:flutter/material.dart';

class FullImage extends StatefulWidget {
  final image;

  const FullImage(this.image, {Key? key}) : super(key: key);

  @override
  State<FullImage> createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: Dim().d350,
            width: double.infinity,
            child: Image.network(widget.image, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
