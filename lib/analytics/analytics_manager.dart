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

  logSelectItemViewEvent(ItemModel itemModel) {
    FirebaseEvent.instance.logSelectItemViewEvent(itemModel);
    MoEngageManager.instance.logSelectItemViewEvent(itemModel);
  }

  setProductListViewEvent(List<ItemModel> list) {
    FirebaseEvent.instance.setProductListViewEvent(list);
    MoEngageManager.instance.setProductListViewEvent(list);
  }

  logItemViewEvent(ItemEventModel eventModel) {
    FBEventManager.instance.viewItemEvent(eventModel);
    FirebaseEvent.instance.logItemViewEvent(eventModel.itemModel);
    MoEngageManager.instance.logItemViewEvent(eventModel.itemModel);
  }

  logAddToCart(ItemModel itemModel) {
    FirebaseEvent.instance.logAddToCart(itemModel);
    MoEngageManager.instance.logAddToCart(itemModel);
    FBEventManager.instance.addToCart(itemModel);
  }

  logRemoveFromCart(ItemModel itemModel) {
    FirebaseEvent.instance.logRemoveFromCart(itemModel);
    MoEngageManager.instance.logRemoveFromCart(itemModel);
  }

  logAddToWishlist(ItemEventModel eventModel) {
    FirebaseEvent.instance.logAddToWishlist(eventModel.itemModel);
    MoEngageManager.instance.logAddToWishlist(eventModel.itemModel);
    FBEventManager.instance.addToWishlist(eventModel);
  }

  logViewCart(CartModel cartModel) {
    FirebaseEvent.instance.logViewCart(cartModel);
    MoEngageManager.instance.logViewCart(cartModel);
  }

  logBeginCheckout(CartModel cartModel) {
    FBEventManager.instance.initiateCheckout(cartModel);
    FirebaseEvent.instance.logBeginCheckout(cartModel);
    MoEngageManager.instance.logBeginCheckout(cartModel);
  }

  logAddShippingInfo(CartModel cartModel) {
    FirebaseEvent.instance.logAddShippingInfo(cartModel);
    MoEngageManager.instance.logAddShippingInfo(cartModel);
  }

  logPurchase(CartModel cartModel) {
    FBEventManager.instance.purchaseEvents(cartModel);
    FirebaseEvent.instance.logPurchase(cartModel);
    MoEngageManager.instance.logPurchase(cartModel);
  }

  logAddPaymentInfo(CartModel cartModel) {
    FirebaseEvent.instance.logAddPaymentInfo(cartModel);
  }
}
