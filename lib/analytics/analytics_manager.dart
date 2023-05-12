import 'package:analytics_plugin/analytics/facebook/facebook_events.dart';
import 'package:analytics_plugin/analytics/firebase/firebase_events.dart';
import 'package:analytics_plugin/analytics/model/event_model.dart';
import 'package:analytics_plugin/analytics/moengage/moengage_manager.dart';
import 'package:moengage_flutter/moengage_flutter.dart';

class AnalyticsManager {
  static AnalyticsManager analytics = AnalyticsManager.instance;
  static late AnalyticsManager firebaseEvent;
  AnalyticsManager._privateConstructor();
  static final AnalyticsManager instance =
      AnalyticsManager._privateConstructor();
  factory AnalyticsManager() {
    return instance;
  }

  void initializedMoEngage(MoEngageFlutter moPlugin, String appVersion,
      String deviceName, String osVersion, AnalyticsPlaftorm platform) {
    MoEngageManager.instance.initializedMoEngage(
        moPlugin, appVersion, deviceName, osVersion, platform);
  }

  void setAppInstallEvent() {
    MoEngageManager.instance.setAppInstallEvent();
  }

  void setAppUpdateEvent() {
    MoEngageManager.instance.setAppUpdateEvent();
  }

  void setUserAttribute(AnalyticsUserModel userModel) {
    MoEngageManager.instance.setUserAttribute(userModel);
  }

  void resetUser() {
    MoEngageManager.instance.resetUser();
  }

  logSelectItemViewEvent(AnalyticsItemModel analyticsItemModel) {
    FirebaseEvent.instance.logSelectItemViewEvent(analyticsItemModel);
    MoEngageManager.instance.logSelectItemViewEvent(analyticsItemModel);
  }

  setProductListViewEvent(List<AnalyticsItemModel> list) {
    FirebaseEvent.instance.setProductListViewEvent(list);
    MoEngageManager.instance.setProductListViewEvent(list);
  }

  logItemViewEvent(AnalyticsItemEventModel eventModel) {
    FBEventManager.instance.viewItemEvent(eventModel);
    FirebaseEvent.instance.logItemViewEvent(eventModel.analyticsItemModel);
    MoEngageManager.instance.logItemViewEvent(eventModel.analyticsItemModel);
  }

  logAddToCart(AnalyticsItemModel analyticsItemModel) {
    FirebaseEvent.instance.logAddToCart(analyticsItemModel);
    MoEngageManager.instance.logAddToCart(analyticsItemModel);
    FBEventManager.instance.addToCart(analyticsItemModel);
  }

  logRemoveFromCart(AnalyticsItemModel analyticsItemModel) {
    FirebaseEvent.instance.logRemoveFromCart(analyticsItemModel);
    MoEngageManager.instance.logRemoveFromCart(analyticsItemModel);
  }

  logAddToWishlist(AnalyticsItemEventModel eventModel) {
    FirebaseEvent.instance.logAddToWishlist(eventModel.analyticsItemModel);
    MoEngageManager.instance.logAddToWishlist(eventModel.analyticsItemModel);
    FBEventManager.instance.addToWishlist(eventModel);
  }

  logViewCart(AnalyticsCartModel analyticsCartModel) {
    FirebaseEvent.instance.logViewCart(analyticsCartModel);
    MoEngageManager.instance.logViewCart(analyticsCartModel);
  }

  logBeginCheckout(AnalyticsCartModel analyticsCartModel) {
    FBEventManager.instance.initiateCheckout(analyticsCartModel);
    FirebaseEvent.instance.logBeginCheckout(analyticsCartModel);
    MoEngageManager.instance.logBeginCheckout(analyticsCartModel);
  }

  logAddShippingInfo(AnalyticsCartModel analyticsCartModel) {
    FirebaseEvent.instance.logAddShippingInfo(analyticsCartModel);
    MoEngageManager.instance.logAddShippingInfo(analyticsCartModel);
  }

  logPurchase(AnalyticsCartModel analyticsCartModel) {
    FBEventManager.instance.purchaseEvents(analyticsCartModel);
    FirebaseEvent.instance.logPurchase(analyticsCartModel);
    MoEngageManager.instance.logPurchase(analyticsCartModel);
  }

  logAddPaymentInfo(AnalyticsCartModel analyticsCartModel) {
    FirebaseEvent.instance.logAddPaymentInfo(analyticsCartModel);
  }
}
