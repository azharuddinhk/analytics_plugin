import 'package:analytics_plugin/analytics/constant/fb_event_attributes.dart';
import 'package:analytics_plugin/analytics/model/event_model.dart';
import 'package:analytics_plugin/analytics_plugin_method_channel.dart';

class AnalyticsFBEventManager {
  static final AnalyticsFBEventManager _instance = AnalyticsFBEventManager._();

  static AnalyticsFBEventManager get instance => _instance;

  AnalyticsFBEventManager._();

  Future<void> Function(Map<dynamic, dynamic>)? recordFacebookEvent;

  _recordFacebookEvents(Map<String, dynamic> eventParams, String eventName) {
    MethodChannelAnalyticsPlugin.instance
        .recordFacebookEvents(eventName, eventParams);
  }

  logEvents(String name, Map<String, dynamic> attributes) {
    _recordFacebookEvents(attributes, name);
  }

  addToCart(AnalyticsItemModel AnalyticsItemModel) {
    final navKey = AnalyticsItemModel.navKey ?? "";
    final itemName = AnalyticsItemModel.name ?? "";
    final brandName = AnalyticsItemModel.brand ?? "";
    final itemCategory = AnalyticsItemModel.categoryName ?? "";
    var contentParams = <String, dynamic>{};
    contentParams = {
      "Product Name": itemName,
      "Brand Name": brandName,
      "Category Name": itemCategory,
      "item_category": itemCategory,
      "item_name": itemName,
      "item_brand": brandName,
      "item_id": AnalyticsItemModel.id ?? 0,
    };

    Map<String, dynamic> fbParams = {};
    fbParams[FBEventAttributes.paramNameContent] = contentParams;
    fbParams[FBEventAttributes.paramNameContentId] = navKey;
    fbParams[FBEventAttributes.paramNameContentType] =
        navKey.contains("PA-") ? "pack" : "product";
    fbParams[FBEventAttributes.paramNameCurrency] = AnalyticsItemModel.currency;
    fbParams[FBEventAttributes.paramNameValueToSum] =
        AnalyticsItemModel.offerPrice ?? 0.0;
    _recordFacebookEvents(fbParams, FBEventName.eventNameAddedToCart);
  }

  addToWishlist(AnalyticsItemEventModel eventModel) {
    final navKey = eventModel.analyticsItemModel.navKey ?? "";
    final itemName = eventModel.analyticsItemModel.name ?? "";
    final brandName = eventModel.analyticsItemModel.brand ?? "";
    final itemCategory = eventModel.analyticsItemModel.categoryName ?? "";
    final id = eventModel.analyticsItemModel.id ?? 0;
    var contentParams = <String, dynamic>{};
    contentParams = {
      "Product Name": itemName,
      "Brand Name": brandName,
      "Category Name": itemCategory,
      "item_category": itemCategory,
      "item_name": itemName,
      "item_brand": brandName,
      "item_id": id,
      "user_id": eventModel.userId,
    };

    Map<String, dynamic> fbParams = {};
    fbParams[FBEventAttributes.paramNameContent] = contentParams;
    fbParams[FBEventAttributes.paramNameContentId] = navKey;
    fbParams[FBEventAttributes.paramNameContentType] =
        navKey.contains("PA-") ? "pack" : "product";
    fbParams[FBEventAttributes.paramNameCurrency] =
        eventModel.analyticsItemModel.currency;
    fbParams[FBEventAttributes.paramNameValueToSum] =
        eventModel.analyticsItemModel.offerPrice ?? 0.0;
    _recordFacebookEvents(fbParams, FBEventName.eventNameAddedToWishlist);
  }

  initiateCheckout(AnalyticsCartModel cartModel) {
    Map<String, dynamic> fbParams = {};
    fbParams[FBEventAttributes.paramNameNumItems] =
        (cartModel.items?.length ?? 0);
    fbParams[FBEventAttributes.paramNameCurrency] = cartModel.currency;
    fbParams[FBEventAttributes.paramNameValueToSum] =
        cartModel.cartValue ?? 0.0;
    _recordFacebookEvents(fbParams, FBEventName.eventNameInitiatedCheckout);
  }

  purchaseEvents(AnalyticsCartModel cartModel) {
    var fbParams = <String, dynamic>{};
    fbParams[FBEventAttributes.paramNameNumItems] =
        (cartModel.items?.length ?? 0);
    fbParams[FBEventAttributes.paramNameCurrency] = cartModel.currency;
    fbParams[FBEventAttributes.paramNameValueToSum] =
        cartModel.cartValue ?? 0.0;
    _recordFacebookEvents(fbParams, "Purchase");
  }

  viewItemEvent(AnalyticsItemEventModel eventModel) {
    final navKey = eventModel.analyticsItemModel.navKey ?? "";
    final itemName = eventModel.analyticsItemModel.name ?? "";
    final brandName = eventModel.analyticsItemModel.brand ?? "";
    final itemCategory = eventModel.analyticsItemModel.categoryName ?? "";
    final id = eventModel.analyticsItemModel.id ?? 0;

    var contentParams = <String, dynamic>{};
    contentParams = {
      "Product Name": itemName,
      "Brand Name": brandName,
      "Category Name": itemCategory,
      "item_category": itemCategory,
      "item_name": itemName,
      "item_brand": brandName,
      "item_id": id,
      "user_id": eventModel.userId,
    };
    Map<String, dynamic> fbParams = {};
    fbParams[FBEventAttributes.paramNameContent] = contentParams;
    fbParams[FBEventAttributes.paramNameContentId] = navKey;
    fbParams[FBEventAttributes.paramNameContentType] =
        navKey.contains("PA-") ? "pack" : "product";
    fbParams[FBEventAttributes.paramNameCurrency] =
        eventModel.analyticsItemModel.currency;
    fbParams[FBEventAttributes.paramNameValueToSum] =
        eventModel.analyticsItemModel.offerPrice ?? 0.0;
    _recordFacebookEvents(fbParams, FBEventName.eventNameViewedContent);
  }
}
