

import 'package:geolocator/geolocator.dart';

class PermissionGps {
  Future<Position> init() async {
    bool isEnabledGps = await Geolocator.isLocationServiceEnabled();
    if(isEnabledGps){
      LocationPermission permission = await Geolocator.checkPermission();
      return checkPermissionLocation(permission);
    }
    else
      {
        return Future.error("L'accès au GPS n'est pas disponible");
      }

  }

  Future<Position>checkPermissionLocation(LocationPermission permission){
    switch(permission){
      case LocationPermission.deniedForever : return Future.error("Vous ne souhaitez  pas accès qu'on est accès à vos données");
      case LocationPermission.denied : return Geolocator.requestPermission().then((value) => checkPermissionLocation(value));
      case LocationPermission.unableToDetermine : return Future.error("Nous n'arrivons à vous positionnez");
      case LocationPermission.whileInUse : return Geolocator.getCurrentPosition();
      case LocationPermission.always : return Geolocator.getCurrentPosition();
    }

  }
}