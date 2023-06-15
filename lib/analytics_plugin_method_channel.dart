import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'analytics_plugin_platform_interface.dart';

/// An implementation of [AnalyticsPluginPlatform] that uses method channels.
class MethodChannelAnalyticsPlugin extends AnalyticsPluginPlatform {
  /// The method channel used to interact with the native platform.
  static late MethodChannelAnalyticsPlugin channelInvocation;
  MethodChannelAnalyticsPlugin._privateConstructor();
  static final MethodChannelAnalyticsPlugin instance =
      MethodChannelAnalyticsPlugin._privateConstructor();

  factory MethodChannelAnalyticsPlugin() {
    return instance;
  }
  @visibleForTesting
  final methodChannel = const MethodChannel('analytics_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  Future<bool> recordAWSEvents(
      String eventName, Map<String, String> eventParams) async {
    try {
      Map arguments = {};
      arguments['eventName'] = eventName;
      arguments['eventAttribute'] = eventParams;
      await methodChannel.invokeMethod('recordAWSEvent', arguments);
      return true;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> recordFacebookEvents(
      String eventName, Map<String, dynamic> eventParams) async {
    try {
      Map arguments = {};
      arguments['eventName'] = eventName;
      arguments['eventAttribute'] = eventParams;
      await methodChannel.invokeMethod('recordFacebookEvents', arguments);
      return true;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> initialisedRudderClient(String writeKey, String dataUrl) async {
    try {
      Map arguments = {};
      arguments['writeKey'] = writeKey;
      arguments['dataUrl'] = dataUrl;
      await methodChannel.invokeMethod('initialisedRudderClient', arguments);
      return true;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> recordRudderStackEvents(
      String eventName, Map<String, dynamic> eventParams) async {
    try {
      Map arguments = {};
      arguments['eventName'] = eventName;
      arguments['eventAttribute'] = eventParams;
      await methodChannel.invokeMethod('recordRudderStackEvents', arguments);
      return true;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> recordRudderStackScreenEvent(String screenName) async {
    try {
      Map arguments = {};
      arguments['screenName'] = screenName;
      await methodChannel.invokeMethod(
          'recordRudderStackScreenEvent', arguments);
      return true;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> recordRudderStackUserEvent(
      Map<String, dynamic> eventParams) async {
    try {
      await methodChannel.invokeMethod(
          'recordRudderStackUserEvent', eventParams);
      return true;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetRudderStackUser() async {
    try {
      await methodChannel.invokeMethod('resetRudderStackUser');
      return true;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
