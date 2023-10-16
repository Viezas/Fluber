


import 'package:permission_handler/permission_handler.dart';

class PermissionPhoto {
  init() async{
    PermissionStatus status = await  Permission.photos.status;
    checkPermission(status);
  }

  Future<PermissionStatus>checkPermission(PermissionStatus status){
    switch(status){
      case PermissionStatus.permanentlyDenied : return Future.error("L'utilisateur ne souhaite pas qu'on accède à ses photos");
      case PermissionStatus.denied : return Permission.photos.request();
      case PermissionStatus.restricted : return Permission.photos.request();
      case PermissionStatus.limited :return Permission.photos.request();
      case PermissionStatus.provisional : return Permission.photos.request();
      case PermissionStatus.granted:return Permission.photos.request();
    }

  }

}