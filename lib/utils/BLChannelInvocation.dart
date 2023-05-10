import 'package:flutter/services.dart';

class BLChannelInvocation {
  static const platform = const MethodChannel('flutter.native/helper');
  static late BLChannelInvocation channelInvocation;

  BLChannelInvocation._privateConstructor();

  static final BLChannelInvocation instance =
  BLChannelInvocation._privateConstructor();

  factory BLChannelInvocation() {
    return instance;
  }

  Future<bool> recordFacebookEvents(
      Map<String, dynamic> eventParams, String eventName) async {
    try {
      Map arguments = Map();
      arguments['eventName'] = eventName;
      arguments['eventAttribute'] = eventParams;
      await platform.invokeMethod('recordFacebookEvents', arguments);
      return true;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
