import 'package:analytics_plugin/analytics/facebook/facebook_events.dart';
import 'package:analytics_plugin/analytics/firebase/firebase_events.dart';
import 'package:analytics_plugin/analytics/model/event_model.dart';
import 'package:analytics_plugin/analytics/moengage/moengage_manager.dart';
import 'package:moengage_flutter/moengage_flutter.dart';

class AnalyticsManager {
  static AnalyticsManager analytics = AnalyticsManager.instance;
  AnalyticsManager._privateConstructor();
  static final AnalyticsManager instance =
  AnalyticsManager._privateConstructor();
  bool isMoengage = false;
  bool isFirebase = false;
  factory AnalyticsManager() {
    return instance;
  }

  void initializedAnalytics(
      MoEngageFlutter moPlugin,
      String appVersion,
      String deviceName,
      String osVersion,
      AnalyticsPlaftorm platform,
      bool isMoengage,
      bool isFirebase) {
    isMoengage = isMoengage;
    isFirebase = isFirebase;
    AnalyticsMoEngageManager.instance.initializedMoEngage(
        moPlugin, appVersion, deviceName, osVersion, platform);
  }

  void setScreenViewEvents(String screenName) {
    if (isFirebase)
      AnalyticsFirebaseEvent.instance.recordScreenView(screenName);
  }

  void setAppInstallEvent() {
    if (isMoengage) AnalyticsMoEngageManager.instance.setAppInstallEvent();
  }

  void setAppUpdateEvent() {
    if (isMoengage) AnalyticsMoEngageManager.instance.setAppUpdateEvent();
  }

  void setUserAttribute(AnalyticsUserModel userModel) {
    if (isMoengage)
      AnalyticsMoEngageManager.instance.setUserAttribute(userModel);
  }

  void resetUser() {
    if (isMoengage) AnalyticsMoEngageManager.instance.resetUser();
  }

  logSelectItemViewEvent(AnalyticsItemModel analyticsItemModel) {
    if (isFirebase)
      AnalyticsFirebaseEvent.instance
          .logSelectItemViewEvent(analyticsItemModel);
    if (isMoengage)
      AnalyticsMoEngageManager.instance
          .logSelectItemViewEvent(analyticsItemModel);
  }

  setProductListViewEvent(List<AnalyticsItemModel> list) {
    if (isFirebase)
      AnalyticsFirebaseEvent.instance.setProductListViewEvent(list);
    if (isMoengage)
      AnalyticsMoEngageManager.instance.setProductListViewEvent(list);
  }

  logItemViewEvent(AnalyticsItemEventModel eventModel) {
    AnalyticsFBEventManager.instance.viewItemEvent(eventModel);
    if (isFirebase)
      AnalyticsFirebaseEvent.instance
          .logItemViewEvent(eventModel.analyticsItemModel);
    if (isMoengage)
      AnalyticsMoEngageManager.instance
          .logItemViewEvent(eventModel.analyticsItemModel);
  }

  logAddToCart(AnalyticsItemModel analyticsItemModel) {
    if (isFirebase)
      AnalyticsFirebaseEvent.instance.logAddToCart(analyticsItemModel);
    if (isMoengage)
      AnalyticsMoEngageManager.instance.logAddToCart(analyticsItemModel);
    AnalyticsFBEventManager.instance.addToCart(analyticsItemModel);
  }

  logRemoveFromCart(AnalyticsItemModel analyticsItemModel) {
    if (isFirebase)
      AnalyticsFirebaseEvent.instance.logRemoveFromCart(analyticsItemModel);
    if (isMoengage)
      AnalyticsMoEngageManager.instance.logRemoveFromCart(analyticsItemModel);
  }

  logAddToWishlist(AnalyticsItemEventModel eventModel) {
    if (isFirebase)
      AnalyticsFirebaseEvent.instance
          .logAddToWishlist(eventModel.analyticsItemModel);
    if (isMoengage)
      AnalyticsMoEngageManager.instance
          .logAddToWishlist(eventModel.analyticsItemModel);
    AnalyticsFBEventManager.instance.addToWishlist(eventModel);
  }

  logViewCart(AnalyticsCartModel analyticsCartModel) {
    if (isFirebase)
      AnalyticsFirebaseEvent.instance.logViewCart(analyticsCartModel);
    if (isMoengage)
      AnalyticsMoEngageManager.instance.logViewCart(analyticsCartModel);
  }

  logBeginCheckout(AnalyticsCartModel analyticsCartModel) {
    AnalyticsFBEventManager.instance.initiateCheckout(analyticsCartModel);
    if (isFirebase)
      AnalyticsFirebaseEvent.instance.logBeginCheckout(analyticsCartModel);
    if (isMoengage)
      AnalyticsMoEngageManager.instance.logBeginCheckout(analyticsCartModel);
  }

  logAddShippingInfo(AnalyticsCartModel analyticsCartModel) {
    if (isFirebase)
      AnalyticsFirebaseEvent.instance.logAddShippingInfo(analyticsCartModel);
    if (isMoengage)
      AnalyticsMoEngageManager.instance.logAddShippingInfo(analyticsCartModel);
  }

  logPurchase(AnalyticsCartModel analyticsCartModel) {
    AnalyticsFBEventManager.instance.purchaseEvents(analyticsCartModel);
    if (isFirebase)
      AnalyticsFirebaseEvent.instance.logPurchase(analyticsCartModel);
    if (isMoengage)
      AnalyticsMoEngageManager.instance.logPurchase(analyticsCartModel);
  }

  logAddPaymentInfo(AnalyticsCartModel analyticsCartModel) {
    if (isFirebase)
      AnalyticsFirebaseEvent.instance.logAddPaymentInfo(analyticsCartModel);
  }
}