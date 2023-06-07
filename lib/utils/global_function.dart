import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeviceId() async {
  String deviceId = '';
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  if(Platform.isAndroid){
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    deviceId = androidDeviceInfo.id;
  }else{
    IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    deviceId = iosDeviceInfo.utsname.machine;
  }
  return deviceId;
}

Future<String> getDeviceName() async {
  String deviceName = '';
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  if(Platform.isAndroid){
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    deviceName = androidDeviceInfo.model;
  }else{
    IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    deviceName = iosDeviceInfo.utsname.sysname;
  }
  return deviceName;
}