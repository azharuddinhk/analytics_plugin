import 'analytics_plugin_platform_interface.dart';
class AnalyticsPlugin {
  Future<String?> getPlatformVersion() {
    return AnalyticsPluginPlatform.instance.getPlatformVersion();
  }
}
