import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'analytics_plugin_method_channel.dart';

abstract class AnalyticsPluginPlatform extends PlatformInterface {
  /// Constructs a AnalyticsPluginPlatform.
  AnalyticsPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static AnalyticsPluginPlatform _instance = MethodChannelAnalyticsPlugin();

  /// The default instance of [AnalyticsPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelAnalyticsPlugin].
  static AnalyticsPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AnalyticsPluginPlatform] when
  /// they register themselves.
  static set instance(AnalyticsPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
