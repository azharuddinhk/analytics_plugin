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
  factory AnalyticsManager() {
    return instance;
  }

  void initializedMoEngage(MoEngageFlutter moPlugin, String appVersion,
      String deviceName, String osVersion, AnalyticsPlaftorm platform) {
    AnalyticsMoEngageManager.instance.initializedMoEngage(
        moPlugin, appVersion, deviceName, osVersion, platform);
  }

  void setAppInstallEvent() {
    AnalyticsMoEngageManager.instance.setAppInstallEvent();
  }

  void setAppUpdateEvent() {
    AnalyticsMoEngageManager.instance.setAppUpdateEvent();
  }

  void setUserAttribute(AnalyticsUserModel userModel) {
    AnalyticsMoEngageManager.instance.setUserAttribute(userModel);
  }

  void resetUser() {
    AnalyticsMoEngageManager.instance.resetUser();
  }

  logSelectItemViewEvent(AnalyticsItemModel analyticsItemModel) {
    AnalyticsFirebaseEvent.instance.logSelectItemViewEvent(analyticsItemModel);
    AnalyticsMoEngageManager.instance.logSelectItemViewEvent(analyticsItemModel);
  }

  setProductListViewEvent(List<AnalyticsItemModel> list) {
    AnalyticsFirebaseEvent.instance.setProductListViewEvent(list);
    AnalyticsMoEngageManager.instance.setProductListViewEvent(list);
  }

  logItemViewEvent(AnalyticsItemEventModel eventModel) {
    AnalyticsFBEventManager.instance.viewItemEvent(eventModel);
    AnalyticsFirebaseEvent.instance.logItemViewEvent(eventModel.analyticsItemModel);
    AnalyticsMoEngageManager.instance.logItemViewEvent(eventModel.analyticsItemModel);
  }

  logAddToCart(AnalyticsItemModel analyticsItemModel) {
    AnalyticsFirebaseEvent.instance.logAddToCart(analyticsItemModel);
    AnalyticsMoEngageManager.instance.logAddToCart(analyticsItemModel);
    AnalyticsFBEventManager.instance.addToCart(analyticsItemModel);
  }

  logRemoveFromCart(AnalyticsItemModel analyticsItemModel) {
    AnalyticsFirebaseEvent.instance.logRemoveFromCart(analyticsItemModel);
    AnalyticsMoEngageManager.instance.logRemoveFromCart(analyticsItemModel);
  }

  logAddToWishlist(AnalyticsItemEventModel eventModel) {
    AnalyticsFirebaseEvent.instance.logAddToWishlist(eventModel.analyticsItemModel);
    AnalyticsMoEngageManager.instance.logAddToWishlist(eventModel.analyticsItemModel);
    AnalyticsFBEventManager.instance.addToWishlist(eventModel);
  }

  logViewCart(AnalyticsCartModel analyticsCartModel) {
    AnalyticsFirebaseEvent.instance.logViewCart(analyticsCartModel);
    AnalyticsMoEngageManager.instance.logViewCart(analyticsCartModel);
  }

  logBeginCheckout(AnalyticsCartModel analyticsCartModel) {
    AnalyticsFBEventManager.instance.initiateCheckout(analyticsCartModel);
    AnalyticsFirebaseEvent.instance.logBeginCheckout(analyticsCartModel);
    AnalyticsMoEngageManager.instance.logBeginCheckout(analyticsCartModel);
  }

  logAddShippingInfo(AnalyticsCartModel analyticsCartModel) {
    AnalyticsFirebaseEvent.instance.logAddShippingInfo(analyticsCartModel);
    AnalyticsMoEngageManager.instance.logAddShippingInfo(analyticsCartModel);
  }

  logPurchase(AnalyticsCartModel analyticsCartModel) {
    AnalyticsFBEventManager.instance.purchaseEvents(analyticsCartModel);
    AnalyticsFirebaseEvent.instance.logPurchase(analyticsCartModel);
    AnalyticsMoEngageManager.instance.logPurchase(analyticsCartModel);
  }

  logAddPaymentInfo(AnalyticsCartModel analyticsCartModel) {
    AnalyticsFirebaseEvent.instance.logAddPaymentInfo(analyticsCartModel);
  }
}
