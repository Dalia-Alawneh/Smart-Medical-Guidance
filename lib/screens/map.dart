import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smg_senior/Util/colors.dart';

class MapScreen extends StatefulWidget {
  // const MapScreen({super.key});
  var googlemapl;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(37.4252745, -122.05745542), zoom: 15);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 200),
            child: GoogleMap(
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3.4,
            left: 0,
            right: 0,
            child: Container(
              // height: 900,
              decoration: BoxDecoration(
                  color: KColor.secBlueColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
            ),
          ),
          Positioned(
              height: 200, bottom: 0, left: 0, right: 0, child: draggable()),
        ],
      ),
    );
  }

  Widget draggable() {
    return Container(
      color: Colors.red,
      child: Column(children: [
        Container(
          margin: EdgeInsets.all(10),
          width: 35,
          height: 3.5,
          color: Colors.grey,
        ),
        heading()
      ]),
    );
  }

  Widget heading() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "العيادات القريبة من منطقتك",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
      ),
    );
  }
}
