import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  final double lat, lng;
  final List<Marker> markerList;

  const Maps(this.lat, this.lng, this.markerList, {Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late GoogleMapController mapController;
  List<Marker> markerList = [];
  late double lat, lng;

  @override
  void initState() {
    lat = widget.lat;
    lng = widget.lng;
    markerList = widget.markerList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff333741),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            // ignore: prefer_const_constructors
            child: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffffc107),
            ),
          ),
        ),
        body: GoogleMap(
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
          markers: markerList.toSet(),
          indoorViewEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, lng),
            zoom: 15,
          ),
          onMapCreated: (controller) {
            mapController = controller;
          },
        ),
      ),
    );
  }
}
