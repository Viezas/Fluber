import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMaps extends StatefulWidget {
  final Position myPosition;
  const MyGoogleMaps({required this.myPosition,super.key});

  @override
  State<MyGoogleMaps> createState() => _MyGoogleMapsState();
}

class _MyGoogleMapsState extends State<MyGoogleMaps> {
  late CameraPosition cameraPosition;
  Completer<GoogleMapController> controller = Completer();

  @override
  void initState() {
    // TODO: implement initState
    cameraPosition = CameraPosition(target: LatLng(widget.myPosition.latitude, widget.myPosition.longitude),zoom: 14);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: (control) async {
          String newStyle = await DefaultAssetBundle.of(context).loadString("lib/newStyle.json");
          control.setMapStyle(newStyle);
          controller.complete(control);
      },
    );
  }
}
