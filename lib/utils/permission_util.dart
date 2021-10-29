
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionUtil{
  ///请求android,ios的相册
  static Future<bool> requestPhoto() async{
    return await request(Platform.isAndroid?Permission.storage:Permission.photos);
  }

  ///请求android,ios的相机
  static Future<bool> requestCamera() async{
   return await request(Permission.camera);
  }
  //获取存储权限
  static Future<bool> requestStorage() async{
    return await request(Permission.storage);
  }
  static Future<bool> request(Permission permission) async{
    PermissionStatus permissionStatus = await permission.status;

    if(permissionStatus==PermissionStatus.granted){ //已受权
      return true;
    }else if(permissionStatus==PermissionStatus.denied){ //未受权
      if(Platform.isAndroid){
        var permissionStatus2 = await permission.request();
        var b =   permissionStatus2.isGranted;
        return b;
      }else{
        openSetting();
        return false;
      }
    }
    // else if(permissionStatus==PermissionStatus.limited){ //undetermined
    //   var permissionStatus2 = await permission.request();
    //   var b = await permissionStatus2.isGranted;
    //   return b;
    // }
    else if(permissionStatus==PermissionStatus.permanentlyDenied||permissionStatus==PermissionStatus.restricted){
      openSetting();
      return false;
    }
    return false;
  }

  ///打开权限设置,引导用户打开
  static void openSetting(){
    openAppSettings();
  }

}