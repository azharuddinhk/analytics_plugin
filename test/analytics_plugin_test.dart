import 'package:flutter_test/flutter_test.dart';
import 'package:analytics_plugin/analytics_plugin.dart';
import 'package:analytics_plugin/analytics_plugin_platform_interface.dart';
import 'package:analytics_plugin/analytics_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAnalyticsPluginPlatform
    with MockPlatformInterfaceMixin
    implements AnalyticsPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AnalyticsPluginPlatform initialPlatform = AnalyticsPluginPlatform.instance;

  test('$MethodChannelAnalyticsPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAnalyticsPlugin>());
  });

  test('getPlatformVersion', () async {
    AnalyticsPlugin analyticsPlugin = AnalyticsPlugin();
    MockAnalyticsPluginPlatform fakePlatform = MockAnalyticsPluginPlatform();
    AnalyticsPluginPlatform.instance = fakePlatform;

    expect(await analyticsPlugin.getPlatformVersion(), '42');
  });
}
