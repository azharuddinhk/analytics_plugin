import 'package:analytics_plugin/analytics/constant/mo_event_attributes.dart';
import 'package:analytics_plugin/analytics/constant/mo_event_names.dart';
import 'package:analytics_plugin/analytics/model/event_model.dart';
import 'package:moengage_flutter/model/app_status.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_flutter/properties.dart';

class AnalyticsMoEngageManager {
  static AnalyticsMoEngageManager _instance = AnalyticsMoEngageManager._();
  static AnalyticsMoEngageManager get instance => _instance;
  AnalyticsMoEngageManager._();
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
      properties.addAttribute(
          AnalyticsMoEventAttributes.platform, _platForm.toString());
      properties.addAttribute(AnalyticsMoEventAttributes.version, _appVersion);
      properties.addAttribute(AnalyticsMoEventAttributes.osVersion, _osVersion);
      properties.addAttribute(
          AnalyticsMoEventAttributes.deviceName, _deviceName);
      _moEngagePlugin!.trackEvent(eventName, properties);
    }
  }

  setProductListViewEvent(List<AnalyticsItemModel> listItems) async {
    if (_moEngagePlugin != null) {
      List<String> items = getItemsFromList(listItems);
      MoEProperties properties = MoEProperties();
      properties.addAttribute(AnalyticsMoEventAttributes.items, items);
      trackEvents(MOEventNames.VIEW_ITEM, properties);
    }
  }

  logSelectItemViewEvent(AnalyticsItemModel data) {
    if (_moEngagePlugin != null) {
      trackEvents(MOEventNames.SELECT_ITEM, getAnalyticsEventItem(data));
    }
  }

  logItemViewEvent(AnalyticsItemModel data) {
    if (_moEngagePlugin != null) {
      trackEvents(MOEventNames.VIEW_ITEM, getAnalyticsEventItem(data));
    }
  }

  logAddToCart(AnalyticsItemModel data) async {
    if (_moEngagePlugin != null) {
      trackEvents(MOEventNames.ADD_TO_CART,
          getAnalyticsEventItemWithQuantity(data, data.quantity ?? 1));
    }
  }

  logAddToWishlist(AnalyticsItemModel data) async {
    if (_moEngagePlugin != null) {
      trackEvents(MOEventNames.ADD_TO_WISHLIST,
          getAnalyticsEventItemWithQuantity(data, data.quantity ?? 1));
    }
  }

  logRemoveFromCart(AnalyticsItemModel data) async {
    if (_moEngagePlugin != null) {
      trackEvents(MOEventNames.REMOVE_FROM_CART,
          getAnalyticsEventItemWithQuantity(data, data.quantity ?? 1));
    }
  }

  logAddToWishlistVariant(AnalyticsItemModel data, int quantity) async {
    if (_moEngagePlugin != null) {
      trackEvents(MOEventNames.ADD_TO_WISHLIST,
          getAnalyticsEventItemWithQuantity(data, quantity));
    }
  }

  logViewCart(AnalyticsCartModel cartModel) {
    if (_moEngagePlugin != null && cartModel.items != null) {
      List<String> items = getItemsFromList(cartModel.items!);
      MoEProperties properties = MoEProperties();
      properties
          .addAttribute(AnalyticsMoEventAttributes.items, items)
          .addAttribute(AnalyticsMoEventAttributes.currency, "INR")
          .addAttribute(AnalyticsMoEventAttributes.value, cartModel.cartValue);
      trackEvents(MOEventNames.VIEW_CART, properties);
    }
  }

  logBeginCheckout(AnalyticsCartModel cartModel) {
    if (_moEngagePlugin != null && cartModel.items != null) {
      List<String> items = getItemsFromList(cartModel.items!);
      MoEProperties properties = MoEProperties();
      properties
          .addAttribute(AnalyticsMoEventAttributes.items, items)
          .addAttribute(AnalyticsMoEventAttributes.currency, "INR")
          .addAttribute(
              AnalyticsMoEventAttributes.coupon, cartModel.couponCode ?? "")
          .addAttribute(AnalyticsMoEventAttributes.value, cartModel.cartValue);
      trackEvents(MOEventNames.BEGIN_CHECKOUT, properties);
    }
  }

  logAddShippingInfo(AnalyticsCartModel cartModel) async {
    if (_moEngagePlugin != null && cartModel.items != null) {
      List<String> items = getItemsFromList(cartModel.items!);
      MoEProperties properties = MoEProperties();
      properties
          .addAttribute(AnalyticsMoEventAttributes.items, items)
          .addAttribute(AnalyticsMoEventAttributes.currency, "INR")
          .addAttribute(
              AnalyticsMoEventAttributes.coupon, cartModel.couponCode ?? "")
          .addAttribute(AnalyticsMoEventAttributes.shipping,
              cartModel.shippingAddress ?? "")
          .addAttribute(AnalyticsMoEventAttributes.value, cartModel.cartValue);
      trackEvents(MOEventNames.ADD_SHIPPING_INFO, properties);
    }
  }

  logPurchase(AnalyticsCartModel cartModel) {
    if (_moEngagePlugin != null && cartModel.items != null) {
      List<String> items = getItemsFromList(cartModel.items!);
      MoEProperties properties = MoEProperties();
      properties
          .addAttribute(AnalyticsMoEventAttributes.items, items)
          .addAttribute(AnalyticsMoEventAttributes.currency, "INR")
          .addAttribute(
              AnalyticsMoEventAttributes.coupon, cartModel.couponCode ?? "")
          .addAttribute(AnalyticsMoEventAttributes.shippingCharge,
              cartModel.shippingCharge)
          .addAttribute(AnalyticsMoEventAttributes.value, cartModel.cartValue)
          .addAttribute(
              AnalyticsMoEventAttributes.transaction_id, cartModel.cartValue);
      trackEvents(MOEventNames.PURCHASE, properties);
    }
  }
}

extension MoEngageEventHelper on AnalyticsMoEngageManager {
  MoEProperties getAnalyticsEventItem(AnalyticsItemModel product) {
    MoEProperties params = MoEProperties();
    params
        .addAttribute(AnalyticsMoEventAttributes.item_id, "${product.id ?? 0}")
        .addAttribute(AnalyticsMoEventAttributes.item_name, product.name ?? "")
        .addAttribute(AnalyticsMoEventAttributes.item_category,
            product.categoryName ?? "")
        .addAttribute(
            AnalyticsMoEventAttributes.item_brand, product.brand ?? "")
        .addAttribute(AnalyticsMoEventAttributes.price, product.offerPrice);
    return params;
  }

  MoEProperties getAnalyticsEventItemWithQuantity(
      AnalyticsItemModel product, int quantity) {
    MoEProperties params = MoEProperties();
    params
        .addAttribute(AnalyticsMoEventAttributes.item_id, "${product.id ?? 0}")
        .addAttribute(AnalyticsMoEventAttributes.item_name, product.name ?? "")
        .addAttribute(AnalyticsMoEventAttributes.item_category,
            product.categoryName ?? "")
        .addAttribute(
            AnalyticsMoEventAttributes.item_brand, product.brand ?? "")
        .addAttribute(AnalyticsMoEventAttributes.quantity, quantity)
        .addAttribute(AnalyticsMoEventAttributes.price, product.offerPrice);
    return params;
  }

  List<String> getItemsFromList(List<AnalyticsItemModel> listItems) {
    List<String> items = [];
    listItems.forEach((element) {
      items.add("${element.name ?? ""}||${element.id}||${element.offerPrice} ");
    });
    return items;
  }
}
