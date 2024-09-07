import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils{

  static Future<bool> storagePermission() async {
    final DeviceInfoPlugin info = DeviceInfoPlugin(); // import 'package:device_info_plus/device_info_plus.dart';


    bool havePermission = false;

    if(Platform.isAndroid){
      final AndroidDeviceInfo androidInfo = await info.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        final request = await [
          Permission.videos,
          Permission.photos,
          //..... as needed
        ].request(); //import 'package:permission_handler/permission_handler.dart';

        havePermission = request.values.every((status) => status == PermissionStatus.granted);
      } else {
        final status = await Permission.storage.request();
        havePermission = status.isGranted;
      }

      if (!havePermission) {
        // if no permission then open app-setting
        await openAppSettings();
      }

      return havePermission;
    }else if(Platform.isIOS){
      final status = await Permission.storage.request();
      if(status.isGranted){
        havePermission=status.isGranted;
      }
    }

    return havePermission;

  }

}