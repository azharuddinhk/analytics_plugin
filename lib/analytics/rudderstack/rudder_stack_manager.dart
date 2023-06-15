import 'dart:core';
import 'package:analytics_plugin/analytics/aws/constant/aws_event_attributes.dart';
import 'package:analytics_plugin/analytics/aws/constant/aws_event_name.dart';
import 'package:analytics_plugin/analytics/model/event_model.dart';
import 'package:analytics_plugin/analytics_plugin_method_channel.dart';

class RudderStackManager {
  static RudderStackManager _instance = RudderStackManager._();
  static RudderStackManager get instance => _instance;
  RudderStackManager._();

  initialisedRudderClient(String writeKey, String dataUrl) {
    MethodChannelAnalyticsPlugin.instance
        .initialisedRudderClient(writeKey, dataUrl);
  }

  setSingleAttributeEvent(
      {required String eventName, required String key, required String value}) {
    Map<String, dynamic> params = <String, dynamic>{};
    params[key] = value;
    MethodChannelAnalyticsPlugin.instance
        .recordRudderStackEvents(eventName, params);
  }

  setEventWithAttributes(String eventName, Map<String, dynamic> params) {
    MethodChannelAnalyticsPlugin.instance
        .recordRudderStackEvents(eventName, params);
  }

  setProductListViewEvent(List<AnalyticsItemModel> analyticsItems) {
    List<Map<String, dynamic>> items = [];
    String categoryName = "";
    if (analyticsItems.isNotEmpty) {
      for (int i = 0; i < analyticsItems.length; i++) {
        AnalyticsItemModel model = analyticsItems[i];
        categoryName = model.categoryName ?? "";
        Map<String, dynamic> productMap = _productMapAnalyticsItemModel(model);
        productMap[AWSEventAttributes.position] = i + 1;
        items.add(productMap);
        if (i == 3) {
          break;
        }
      }
      Map<String, dynamic> params = <String, dynamic>{};
      params[AWSEventAttributes.products] = items;
      params[AWSEventAttributes.category] = categoryName;
      params[AWSEventAttributes.category] = categoryName;
      MethodChannelAnalyticsPlugin.instance
          .recordRudderStackEvents(AWSEventNames.PRODUCT_LIST_VIEW, params);
    }
  }

  setProductEvent(String eventName, AnalyticsItemModel model,
      {int? itemPosition}) {
    Map<String, dynamic> params = _productMapAnalyticsItemModel(model);
    if (itemPosition != null) {
      params[AWSEventAttributes.position] = itemPosition;
    }
    MethodChannelAnalyticsPlugin.instance
        .recordRudderStackEvents(eventName, params);
  }

  setWishlistAddtoCartEvent(AnalyticsItemModel model) {
    Map<String, dynamic> params = _productMapAnalyticsItemModel(model);
    MethodChannelAnalyticsPlugin.instance.recordRudderStackEvents(
        AWSEventNames.WISHLIST_PRODUCT_ADDED_TO_CART, params);
  }

  setCartViewEvent(AnalyticsCartModel cartModel) {
    List<Map<String, dynamic>> items = [];
    if (cartModel.items != null) {
      cartModel.items!.forEach((element) {
        items.add(_productMapAnalyticsItemModel(element));
      });
    }
    Map<String, dynamic> params = <String, dynamic>{};
    params[AWSEventAttributes.cartId] = cartModel.cartId ?? 0;
    params[AWSEventAttributes.products] = items;
    MethodChannelAnalyticsPlugin.instance
        .recordRudderStackEvents(AWSEventNames.CART_VIEW, params);
  }

  checkoutStartedEvent(AnalyticsCartModel cartModel) {
    List<Map<String, dynamic>> items = [];
    if (cartModel.items != null) {
      cartModel.items!.forEach((element) {
        items.add(_productMapAnalyticsItemModel(element));
      });
    }

    Map<String, dynamic> params = <String, dynamic>{};
    params[AWSEventAttributes.cartId] = cartModel.cartId ?? 0;
    params[AWSEventAttributes.products] = items;
    params[AWSEventAttributes.affiliation] = "";
    params[AWSEventAttributes.value] = cartModel.cartValue ?? 0;
    params[AWSEventAttributes.revenue] = cartModel.cartValue ?? 0;
    params[AWSEventAttributes.shipping] = cartModel.shippingCharge ?? 0;
    params[AWSEventAttributes.tax] = 0;
    params[AWSEventAttributes.discount] = "";
    params[AWSEventAttributes.coupon] = cartModel.couponCode ?? "";
    params[AWSEventAttributes.currency] = AWSEventAttributes.currencyValue;
    MethodChannelAnalyticsPlugin.instance
        .recordRudderStackEvents(AWSEventNames.CHEKOUT_STARTED, params);
  }

  submitProductReview(int productId, String reviewDescription, int rating) {
    Map<String, dynamic> params = <String, dynamic>{};
    params[AWSEventAttributes.product_id] = productId;
    params[AWSEventAttributes.reviewId] = "";
    params[AWSEventAttributes.rating] = rating;
    params[AWSEventAttributes.reviewBody] = reviewDescription;
    MethodChannelAnalyticsPlugin.instance
        .recordRudderStackEvents(AWSEventNames.PRODUCT_REVIEWED, params);
  }

  submitPurchaseEvent(AnalyticsCartModel cartModel) {
    List<Map<String, dynamic>> items = [];
    if (cartModel.items != null) {
      cartModel.items!.forEach((element) {
        items.add(_productMapAnalyticsItemModel(element));
      });
    }

    Map<String, dynamic> params = <String, dynamic>{};
    params[AWSEventAttributes.checkoutId] = cartModel.cartId ?? "";
    params[AWSEventAttributes.orderId] = cartModel.gatewayOrderId ?? "";
    params[AWSEventAttributes.products] = items;
    params[AWSEventAttributes.affiliation] = "";
    params[AWSEventAttributes.total] = cartModel.cartValue ?? 0;
    params[AWSEventAttributes.value] = cartModel.cartValue ?? 0;
    params[AWSEventAttributes.revenue] = cartModel.cartValue ?? 0;
    params[AWSEventAttributes.shipping] = cartModel.shippingCharge ?? 0;
    params[AWSEventAttributes.tax] = 0;
    params[AWSEventAttributes.discount] = "";
    params[AWSEventAttributes.coupon] = cartModel.couponCode;
    params[AWSEventAttributes.currency] = AWSEventAttributes.currencyValue;
    MethodChannelAnalyticsPlugin.instance
        .recordRudderStackEvents(AWSEventNames.ORDER_COMPLETED, params);
  }

  orderCancelEvent(AnalyticsCartModel cartModel) {
    List<Map<String, dynamic>> items = [];
    if (cartModel.items != null) {
      cartModel.items!.forEach((element) {
        items.add(_productMapAnalyticsItemModel(element));
      });
    }

    Map<String, dynamic> params = <String, dynamic>{};
    params[AWSEventAttributes.checkoutId] = cartModel.cartId ?? "";
    params[AWSEventAttributes.orderId] = cartModel.gatewayOrderId ?? "";
    params[AWSEventAttributes.products] = items;
    params[AWSEventAttributes.affiliation] = "";
    params[AWSEventAttributes.total] = cartModel.cartValue ?? 0;
    params[AWSEventAttributes.value] = cartModel.cartValue ?? 0;
    params[AWSEventAttributes.revenue] = cartModel.cartValue ?? 0;
    params[AWSEventAttributes.shipping] = cartModel.shippingCharge ?? 0;
    params[AWSEventAttributes.tax] = 0;
    params[AWSEventAttributes.discount] = "";
    params[AWSEventAttributes.coupon] = cartModel.couponCode;
    params[AWSEventAttributes.currency] = AWSEventAttributes.currencyValue;
    MethodChannelAnalyticsPlugin.instance
        .recordRudderStackEvents(AWSEventNames.ORDER_CANCELLED, params);
  }

  void trackScreenEvents(String screenName) {
    MethodChannelAnalyticsPlugin.instance
        .recordRudderStackScreenEvent(screenName);
  }

  void registerUser(AnalyticsUserModel userModel) {
    Map<String, dynamic> params = <String, dynamic>{};
    params[AWSEventAttributes.email] = userModel.emailId;
    params[AWSEventAttributes.name] = userModel.userName;
    params[AWSEventAttributes.mobile] = "91${userModel.contactNumer}";
    params[AWSEventAttributes.userId] = userModel.userId;
    params["date"] = DateTime.now().millisecondsSinceEpoch;
    MethodChannelAnalyticsPlugin.instance.recordRudderStackUserEvent(params);
  }

  void resetUser() {
    MethodChannelAnalyticsPlugin.instance.resetRudderStackUser();
  }
}

extension RudderStackManagerHelper on RudderStackManager {
  Map<String, dynamic> _productMapAnalyticsItemModel(
      AnalyticsItemModel productData) {
    Map<String, dynamic> eventParams = <String, dynamic>{};
    eventParams[AWSEventAttributes.product_id] = productData.id ?? 0;
    eventParams[AWSEventAttributes.category] = productData.categoryName ?? "";
    eventParams[AWSEventAttributes.name] = productData.name ?? "";
    eventParams[AWSEventAttributes.price] = productData.offerPrice ?? 0.0;
    eventParams[AWSEventAttributes.quantity] = productData.quantity ?? 1;
    eventParams[AWSEventAttributes.currency] = AWSEventAttributes.currencyValue;
    eventParams[AWSEventAttributes.urlWeb] = "";
    eventParams[AWSEventAttributes.image_url] = "";
    eventParams[AWSEventAttributes.sku] = "";
    eventParams[AWSEventAttributes.brand] = productData.brand;
    eventParams[AWSEventAttributes.variant] = "";
    eventParams[AWSEventAttributes.coupon] = "";
    return eventParams;
  }
}
