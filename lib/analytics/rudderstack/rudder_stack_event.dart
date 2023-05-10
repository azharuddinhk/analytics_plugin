class RudderStackEvent {
  static RudderStackEvent _instance = RudderStackEvent._();
  //final RudderController _rudderClient = RudderController.instance;
  static RudderStackEvent get instance => _instance;
  RudderStackEvent._();
  void initializedRudderStack() {
    //RudderLogger.init(RudderLogger.NONE);
    // RudderConfigBuilder builder = RudderConfigBuilder();
    // // builder.withFactory(RudderIntegrationFirebaseFlutter());
    // MobileConfig mc = MobileConfig(
    //   autoCollectAdvertId: false,
    //   recordScreenViews: true,
    //   trackLifecycleEvents: true,
    // );
    // builder.withMobileConfig(mc);
    // builder.withDataPlaneUrl(AppConstant.rudderStackDataPlaneUrl);
    // builder.withDebug(true);
    // _rudderClient.initialize(AppConstant.rudderStackWriteKey,
    //     config: builder.build());
  }

  void trackEvents(String eventName, Map<String, dynamic> parameters) {
    // if (RemoteConfig.instance.isRudderStackEnable()) {
    //   RudderProperty property = RudderProperty.fromMap(parameters);
    //   _rudderClient.track(eventName, properties: property);
    // }
  }

  void trackScreenEvents(String screenName) {
    //RudderProperty property = RudderProperty.fromMap(parameters);
    // if (RemoteConfig.instance.isRudderStackEnable()) {
    //   _rudderClient.screen(screenName);
    // }
  }

  void registerUser(UserModel userModel) {
    // if (RemoteConfig.instance.isRudderStackEnable()) {
    //   RudderTraits traits = RudderTraits();
    //   traits.putBirthdayDate(new DateTime.now());
    //   traits.putEmail(userModel.email ?? "");
    //   traits.putName(userModel.nm ?? "");
    //   traits.putPhone("91" + (userModel.cntNum ?? ""));
    //   traits.putId(SharedPreference().userId());
    //   traits.put("date", new DateTime.now().millisecondsSinceEpoch);
    //   _rudderClient.identify("user", traits: traits, options: null);
    // }
  }

  void resetUser() {
    // if (RemoteConfig.instance.isRudderStackEnable()) {
    //   _rudderClient.reset();
    // }
  }
}


class UserModel{}