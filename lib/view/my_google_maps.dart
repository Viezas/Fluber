import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMaps extends StatefulWidget {
  const MyGoogleMaps({super.key});

  @override
  State<MyGoogleMaps> createState() => _MyGoogleMapsState();
}

class _MyGoogleMapsState extends State<MyGoogleMaps> {
  CameraPosition cameraPosition = CameraPosition(target: LatLng(48.862725, 2.287592),zoom: 14);
  Completer<GoogleMapController> controller = Completer();
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition: cameraPosition,
      onMapCreated: (control) async {
          String newStyle = await DefaultAssetBundle.of(context).loadString("lib/newStyle.json");
          control.setMapStyle(newStyle);
          controller.complete(control);
      },
    );
  }
}
