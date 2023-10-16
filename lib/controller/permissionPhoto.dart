


import 'package:permission_handler/permission_handler.dart';

class PermissionPhoto {
  init() async{
    PermissionStatus status = await  Permission.photos.status;
    checkPermission(status);
  }

}