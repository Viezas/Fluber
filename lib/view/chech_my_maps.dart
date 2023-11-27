import 'package:efrei2023gr3/controller/permissionGps.dart';
import 'package:efrei2023gr3/view/my_google_maps.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CheckMyMaps extends StatefulWidget {
  const CheckMyMaps({super.key});

  @override
  State<CheckMyMaps> createState() => _CheckMyMapsState();
}

class _CheckMyMapsState extends State<CheckMyMaps> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
        future: PermissionGps().init(),
        builder: (context,snap){
          if(snap.connectionState == ConnectionState.waiting){
            return const Center(
                child: CircularProgressIndicator.adaptive()
            );
          }
          else
            {
              if(snap.hasData){
                Position position = snap.data!;
                return  MyGoogleMaps(myPosition: position,);
              }
              else {
                return const Center(
                    child: Text(
                        "L'application ne peut accéder à vos données GPS")
                );
              }
            }


        }
    );
  }
}
