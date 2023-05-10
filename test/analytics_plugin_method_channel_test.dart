import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:analytics_plugin/analytics_plugin_method_channel.dart';

void main() {
  MethodChannelAnalyticsPlugin platform = MethodChannelAnalyticsPlugin();
  const MethodChannel channel = MethodChannel('analytics_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
