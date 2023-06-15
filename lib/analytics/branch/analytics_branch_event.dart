import 'dart:async';

import 'package:analytics_plugin/analytics/aws/constant/aws_event_attributes.dart';
import 'package:analytics_plugin/analytics/model/event_model.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

class AnalyticsBranchEvent {
  static AnalyticsBranchEvent _instance = AnalyticsBranchEvent._();
  static AnalyticsBranchEvent get instance => _instance;
  AnalyticsBranchEvent._();

  void trackBranchEvent(List<BranchUniversalObject> items, BranchEvent event) {
    FlutterBranchSdk.trackContent(buo: items, branchEvent: event);
  }

  void logPurchase(AnalyticsCartModel cartModel) {
    if (cartModel.items != null && (cartModel.items?.length ?? 0) > 0) {
      List<BranchUniversalObject> items = [];
      cartModel.items!.forEach((element) {
        items.add(getAnalyticsItem(element));
      });

      BranchEvent event =
          BranchEvent.standardEvent(BranchStandardEvent.PURCHASE);
      event.transactionID = cartModel.gatewayOrderId ?? "";
      event.currency = BranchCurrencyType.INR;
      event.revenue = cartModel.cartValue ?? 0;
      event.shipping = cartModel.shippingCharge ?? 0;
      event.tax = 0;
      event.coupon = cartModel.couponCode ?? "";
      trackBranchEvent(items, event);
    }
  }

  logViewCart(AnalyticsCartModel cartModel) {
    if (cartModel.items != null && (cartModel.items?.length ?? 0) > 0) {
      List<BranchUniversalObject> items = [];
      cartModel.items!.forEach((element) {
        items.add(getAnalyticsItem(element));
      });
      BranchEvent event =
          BranchEvent.standardEvent(BranchStandardEvent.VIEW_CART);
      event.currency = BranchCurrencyType.INR;
      event.revenue = cartModel.cartValue ?? 0;
      event.shipping = cartModel.shippingCharge ?? 0;
      event.tax = 0;
      event.coupon = cartModel.couponCode ?? "";
      trackBranchEvent(items, event);
    }
  }

  logBeginCheckout(AnalyticsCartModel cartModel) async {
    if (cartModel.items != null && (cartModel.items?.length ?? 0) > 0) {
      List<BranchUniversalObject> items = [];
      cartModel.items!.forEach((element) {
        items.add(getAnalyticsItem(element));
      });
      BranchEvent event =
          BranchEvent.standardEvent(BranchStandardEvent.INITIATE_PURCHASE);
      event.currency = BranchCurrencyType.INR;
      event.revenue = cartModel.cartValue ?? 0;
      event.shipping = cartModel.shippingCharge ?? 0;
      event.tax = 0;
      event.coupon = cartModel.couponCode ?? "";
      trackBranchEvent(items, event);
    }
  }

  Future logAddToWishlistVariant(AnalyticsItemModel analyticsItemModel) async {
    BranchEvent event =
        BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_WISHLIST);
    event.currency = BranchCurrencyType.INR;
    trackBranchEvent([getAnalyticsItem(analyticsItemModel)], event);
  }

  logAddToCart(AnalyticsItemModel analyticsItemModel) {
    BranchEvent event =
        BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART);
    event.currency = BranchCurrencyType.INR;
    trackBranchEvent([getAnalyticsItem(analyticsItemModel)], event);
  }
}

extension BranchEventHelper on AnalyticsBranchEvent {
  BranchUniversalObject getAnalyticsItem(
      AnalyticsItemModel analyticsItemModel) {
    BranchContentMetaData metaData = BranchContentMetaData();
    metaData.sku = analyticsItemModel.id ?? "";
    metaData.productName = analyticsItemModel.name ?? "";
    metaData.price = analyticsItemModel.offerPrice ?? 0.0;
    metaData.quantity = (analyticsItemModel.quantity ?? 1).toDouble();
    metaData.productBrand = analyticsItemModel.brand ?? "";
    metaData.productCategory = BranchProductCategory.HEALTH_AND_BEAUTY;
    metaData.currencyType = BranchCurrencyType.INR;
    metaData.contentSchema = BranchContentSchema.COMMERCE_PRODUCT;
    metaData.addCustomMetadata(
        AWSEventAttributes.category, analyticsItemModel.categoryName ?? "");
    return BranchUniversalObject(
        canonicalIdentifier: analyticsItemModel.id ?? "",
        contentMetadata: metaData);
  }
}
