import 'dart:io';
import 'package:analytics_plugin/analytics/constant/mo_event_attributes.dart';
import 'package:analytics_plugin/analytics/constant/mo_event_names.dart';
import 'package:analytics_plugin/analytics/model/event_model.dart';
import 'package:moengage_flutter/model/app_status.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_flutter/properties.dart';

class MoEngageManager {
  static MoEngageManager _instance = MoEngageManager._();
  static MoEngageManager get instance => _instance;
  MoEngageManager._();
  late MoEngageFlutter? _moEngagePlugin;
  late String _appVersion;
  late String _deviceName;
  late String _osVersion;
  late AnalyticsPlaftorm _platForm;

  void initializedMoEngage(MoEngageFlutter moPlugin, String appVersion,
      String deviceName, String osVersion, AnalyticsPlaftorm platform) {
    _moEngagePlugin = moPlugin;
    _appVersion = appVersion;
    _deviceName = deviceName;
    _platForm = platform;
  }

  void setAppInstallEvent() {
    if (_moEngagePlugin != null) {
      _moEngagePlugin!.setAppStatus(MoEAppStatus.install);
    }
  }

  void setAppUpdateEvent() {
    if (_moEngagePlugin != null) {
      _moEngagePlugin!.setAppStatus(MoEAppStatus.update);
    }
  }

  void setUserAttribute(AnalyticsUserModel userModel) {
    if (_moEngagePlugin != null) {
      _moEngagePlugin!.setUniqueId(userModel.userId);
      _moEngagePlugin!.setUserName(userModel.userName);
      _moEngagePlugin!.setEmail(userModel.emailId);
      _moEngagePlugin!.setPhoneNumber("91${userModel.contactNumer}");
      DateTime now = DateTime.now();
      String isoDate = now.toIso8601String();
      _moEngagePlugin!.setUserAttributeIsoDate("timeStamp", isoDate);
    }
  }

  void resetUser() {
    if (_moEngagePlugin != null) {
      _moEngagePlugin!.logout();
    }
  }

  void trackEvents(String eventName, MoEProperties properties) {
    if (_moEngagePlugin != null) {
      properties.addAttribute(MoEventAttributes.platform, _platForm.toString());
      properties.addAttribute(MoEventAttributes.version, _appVersion);
      properties.addAttribute(MoEventAttributes.osVersion, _osVersion);
      properties.addAttribute(MoEventAttributes.deviceName, _deviceName);
      _moEngagePlugin!.trackEvent(eventName, properties);
    }
  }

  setProductListViewEvent(List<ItemModel> listItems) async {
    if (_moEngagePlugin != null) {
      List<String> items = getItemsFromList(listItems);
      MoEProperties properties = MoEProperties();
      properties.addAttribute(MoEventAttributes.items, items);
      trackEvents(MOEventNames.VIEW_ITEM, properties);
    }
  }

  logSelectItemViewEvent(ItemModel data) {
    if (_moEngagePlugin != null) {
      trackEvents(MOEventNames.SELECT_ITEM, getAnalyticsEventItem(data));
    }
  }

  logItemViewEvent(ItemModel data) {
    if (_moEngagePlugin != null) {
      trackEvents(MOEventNames.VIEW_ITEM, getAnalyticsEventItem(data));
    }
  }

  logAddToCart(ItemModel data) async {
    if (_moEngagePlugin != null) {
      trackEvents(MOEventNames.ADD_TO_CART,
          getAnalyticsEventItemWithQuantity(data, data.quantity ?? 1));
    }
  }

  logAddToWishlist(ItemModel data) async {
    if (_moEngagePlugin != null) {
      trackEvents(MOEventNames.ADD_TO_WISHLIST,
          getAnalyticsEventItemWithQuantity(data, data.quantity ?? 1));
    }
  }

  logRemoveFromCart(ItemModel data) async {
    if (_moEngagePlugin != null) {
      trackEvents(MOEventNames.REMOVE_FROM_CART,
          getAnalyticsEventItemWithQuantity(data, data.quantity ?? 1));
    }
  }

  logAddToWishlistVariant(ItemModel data, int quantity) async {
    if (_moEngagePlugin != null) {
      trackEvents(MOEventNames.ADD_TO_WISHLIST,
          getAnalyticsEventItemWithQuantity(data, quantity));
    }
  }

  logViewCart(CartModel cartModel) {
    if (_moEngagePlugin != null && cartModel.items != null) {
      List<String> items = getItemsFromList(cartModel.items!);
      MoEProperties properties = MoEProperties();
      properties
          .addAttribute(MoEventAttributes.items, items)
          .addAttribute(MoEventAttributes.currency, "INR")
          .addAttribute(MoEventAttributes.value, cartModel.cartValue);
      trackEvents(MOEventNames.VIEW_CART, properties);
    }
  }

  logBeginCheckout(CartModel cartModel) {
    if (_moEngagePlugin != null && cartModel.items != null) {
      List<String> items = getItemsFromList(cartModel.items!);
      MoEProperties properties = MoEProperties();
      properties
          .addAttribute(MoEventAttributes.items, items)
          .addAttribute(MoEventAttributes.currency, "INR")
          .addAttribute(MoEventAttributes.coupon, cartModel.couponCode ?? "")
          .addAttribute(MoEventAttributes.value, cartModel.cartValue);
      trackEvents(MOEventNames.BEGIN_CHECKOUT, properties);
    }
  }

  logAddShippingInfo(CartModel cartModel) async {
    if (_moEngagePlugin != null && cartModel.items != null) {
      List<String> items = getItemsFromList(cartModel.items!);
      MoEProperties properties = MoEProperties();
      properties
          .addAttribute(MoEventAttributes.items, items)
          .addAttribute(MoEventAttributes.currency, "INR")
          .addAttribute(MoEventAttributes.coupon, cartModel.couponCode ?? "")
          .addAttribute(
              MoEventAttributes.shipping, cartModel.shippingAddress ?? "")
          .addAttribute(MoEventAttributes.value, cartModel.cartValue);
      trackEvents(MOEventNames.ADD_SHIPPING_INFO, properties);
    }
  }

  logPurchase(CartModel cartModel) {
    if (_moEngagePlugin != null && cartModel.items != null) {
      List<String> items = getItemsFromList(cartModel.items!);
      MoEProperties properties = MoEProperties();
      properties
          .addAttribute(MoEventAttributes.items, items)
          .addAttribute(MoEventAttributes.currency, "INR")
          .addAttribute(MoEventAttributes.coupon, cartModel.couponCode ?? "")
          .addAttribute(
              MoEventAttributes.shippingCharge, cartModel.shippingCharge)
          .addAttribute(MoEventAttributes.value, cartModel.cartValue)
          .addAttribute(MoEventAttributes.transaction_id, cartModel.cartValue);
      trackEvents(MOEventNames.PURCHASE, properties);
    }
  }
}

extension MoEngageEventHelper on MoEngageManager {
  MoEProperties getAnalyticsEventItem(ItemModel product) {
    MoEProperties params = MoEProperties();
    params
        .addAttribute(MoEventAttributes.item_id, "${product.id ?? 0}")
        .addAttribute(MoEventAttributes.item_name, product.name ?? "")
        .addAttribute(
            MoEventAttributes.item_category, product.categoryName ?? "")
        .addAttribute(MoEventAttributes.item_brand, product.brand ?? "")
        .addAttribute(MoEventAttributes.price, product.offerPrice);
    return params;
  }

  MoEProperties getAnalyticsEventItemWithQuantity(
      ItemModel product, int quantity) {
    MoEProperties params = MoEProperties();
    params
        .addAttribute(MoEventAttributes.item_id, "${product.id ?? 0}")
        .addAttribute(MoEventAttributes.item_name, product.name ?? "")
        .addAttribute(
            MoEventAttributes.item_category, product.categoryName ?? "")
        .addAttribute(MoEventAttributes.item_brand, product.brand ?? "")
        .addAttribute(MoEventAttributes.quantity, quantity)
        .addAttribute(MoEventAttributes.price, product.offerPrice);
    return params;
  }

  List<String> getItemsFromList(List<ItemModel> listItems) {
    List<String> items = [];
    listItems.forEach((element) {
      items.add("${element.name ?? ""}||${element.id}||${element.offerPrice} ");
    });
    return items;
  }
}
