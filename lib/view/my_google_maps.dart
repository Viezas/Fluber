import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MyGoogleMaps extends StatefulWidget {
  final Position myPosition;
  const MyGoogleMaps({required this.myPosition,super.key});

  @override
  State<MyGoogleMaps> createState() => _MyGoogleMapsState();
}

class _MyGoogleMapsState extends State<MyGoogleMaps> {
  late CameraPosition cameraPosition;
  Completer<GoogleMapController> controller = Completer();
  Set<Marker>allMarkers = Set();


  @override
  void initState() {
    // TODO: implement initState
    allMarkers.add(
        Marker(
            markerId: MarkerId("dfhskjfhdskjfh"),
            position: LatLng(widget.myPosition.latitude, widget.myPosition.longitude),)
    );
    cameraPosition = CameraPosition(target: LatLng(widget.myPosition.latitude, widget.myPosition.longitude),zoom: 14);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition: cameraPosition,

      markers: allMarkers,
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
