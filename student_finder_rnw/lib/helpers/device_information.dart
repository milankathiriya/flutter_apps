import 'package:device_info/device_info.dart';
import 'package:get/get_utils/src/platform/platform.dart';

class DeviceInformation {
  DeviceInformation._();

  static final DeviceInformation deviceInformation = DeviceInformation._();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  AndroidDeviceInfo androidDeviceInfo;
  IosDeviceInfo iosInfo;

  Future<String> getDeviceToken() async {
    String token;
    if (GetPlatform.isAndroid) {
      androidDeviceInfo = await deviceInfo.androidInfo;
      token = androidDeviceInfo.androidId;
    }
    if (GetPlatform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
      token = iosInfo.identifierForVendor;
    }
    return token;
  }
}
