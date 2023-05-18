import 'package:analytics_plugin/analytics/analytics_utils.dart';
import 'package:analytics_plugin/analytics/aws/constant/aws_event_attributes.dart';
import 'package:analytics_plugin/analytics/aws/constant/aws_event_name.dart';
import 'package:flutter/services.dart';
import 'constant/model/aws_event_model.dart';

class AWSAnalyticsManager {
  static AWSAnalyticsManager _instance = AWSAnalyticsManager._();
  static AWSAnalyticsManager get instance => _instance;
  AWSAnalyticsManager._();
  String screenName = "";
  String pageName = "";
  AWSAnalyticsTrackerModel? analyticsTrackerModel;
  MethodChannel? methodChannel;

  
  configureAWS(AWSAnalyticsTrackerModel analyticsTrackerModel,
      MethodChannel methodChannel) {
    this.analyticsTrackerModel = analyticsTrackerModel;
    this.methodChannel = methodChannel;
  }

  recordScreenEvents(String screenName) {
    pageName = this.screenName;
    this.screenName = screenName;
    Map<String, String> params = {};
    _addCommonParameter(params);
    recordsEvents(params, AWSEventNames.SCREEN_VIEW);
    print("Screen Name ====== ${params.toString()}");
  }

  addEvent(String eventName, Map<String, String> params) {
    _addCommonParameter(params);
    recordsEvents(params, eventName);
    print("Event Name ======= $eventName ===== ${params.toString()}");
  }

  addEventWithName(String eventName) {
    Map<String, String> params = {};
    _addCommonParameter(params);
    recordsEvents(params, eventName);
    print("Event Name ======= $eventName =====${params.toString()}");
  }

  addEventWithAWSAnalyticsItemEventModel(
      AWSAnalyticsItemEventModel awsAnalyticsItemEventModel) {
    Map<String, String> params = {};
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsItemEventModel.widgetName )) {
      params[AWSEventAttributes.widgetName] =
          awsAnalyticsItemEventModel.widgetName ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsItemEventModel.widgetPosition )) {
      params[AWSEventAttributes.widgetPosition] =
          awsAnalyticsItemEventModel.widgetPosition ?? '';
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsItemEventModel.itemPosition )) {
      params[AWSEventAttributes.itemPosition] =
          awsAnalyticsItemEventModel.itemPosition ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsItemEventModel.eventName )) {
      params[AWSEventAttributes.eventName] =
          awsAnalyticsItemEventModel.eventName ?? "";
    }

    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsItemEventModel.urlFragment )) {
      params[AWSEventAttributes.urlFragment] =
          awsAnalyticsItemEventModel.urlFragment ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsItemEventModel.keyword )) {
      params[AWSEventAttributes.keyword] =
          awsAnalyticsItemEventModel.keyword ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsItemEventModel.searchAction )) {
      params[AWSEventAttributes.searchAction] =
          awsAnalyticsItemEventModel.searchAction ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsItemEventModel.filterType )) {
      params[AWSEventAttributes.filterType] =
          awsAnalyticsItemEventModel.filterType ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsItemEventModel.filterValue )) {
      params[AWSEventAttributes.filterValue] =
          awsAnalyticsItemEventModel.filterValue ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsItemEventModel.searchAction)  &&
        AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsItemEventModel.keyword) ) {
      analyticsTrackerModel?.setSearchData(
          awsAnalyticsItemEventModel.searchAction!,
          awsAnalyticsItemEventModel.keyword!);
    }
    _setItemMapFromItemData(params, awsAnalyticsItemEventModel.analyticsItem);
    addEvent(awsAnalyticsItemEventModel.eventType ?? "", params);
  }

  addEventWithAWSAnalyticsCartModel(
      AWSAnalyticsCartModel awsAnalyticsCartModel) {
    Map<String, String> params = {};
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsCartModel.cartId )) {
      params[AWSEventAttributes.cartId] = awsAnalyticsCartModel.cartId ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsCartModel.shippingAddress )) {
      params[AWSEventAttributes.address] =
          awsAnalyticsCartModel.shippingAddress ?? '';
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsCartModel.currency )) {
      params[AWSEventAttributes.currency] =
          awsAnalyticsCartModel.currency ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsCartModel.couponCode )) {
      params[AWSEventAttributes.couponCode] =
          awsAnalyticsCartModel.couponCode ?? "";
    }

    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsCartModel.cartValue )) {
      params[AWSEventAttributes.value] = awsAnalyticsCartModel.cartValue ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsCartModel.gatewayOrderId )) {
      params[AWSEventAttributes.transactionId] =
          awsAnalyticsCartModel.gatewayOrderId ?? '';
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsCartModel.paymentType )) {
      params[AWSEventAttributes.paymentMode] =
          awsAnalyticsCartModel.paymentType ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsCartModel.pincode )) {
      params[AWSEventAttributes.pincode] = awsAnalyticsCartModel.pincode ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsCartModel.shippingCharge )) {
      params[AWSEventAttributes.shipping] =
          awsAnalyticsCartModel.shippingCharge ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsCartModel.eventName )) {
      params[AWSEventAttributes.eventName] =
          awsAnalyticsCartModel.eventName ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(awsAnalyticsCartModel.numberOfItems )) {
      params[AWSEventAttributes.cartItems] =
          awsAnalyticsCartModel.numberOfItems ?? "";
    }
    _getCartItemMapFromCartModel(params, awsAnalyticsCartModel);
    addEvent(awsAnalyticsCartModel.eventType ?? "", params);
  }
}

extension AmplifyManagerHelper on AWSAnalyticsManager {
  _addCommonParameter(Map<String, String> params) {
    params[AWSEventAttributes.date] = analyticsTrackerModel?.currentDate ?? "";
    params[AWSEventAttributes.deviceId] = analyticsTrackerModel?.deviceId ?? "";
    params[AWSEventAttributes.deviceName] =
        analyticsTrackerModel?.deviceName ?? "";
    params[AWSEventAttributes.version] =
        analyticsTrackerModel?.appVersion ?? "";
    params[AWSEventAttributes.pageName] = pageName;
    params[AWSEventAttributes.platform] =
        analyticsTrackerModel?.plaftorm.toString() ?? "Android";
    params[AWSEventAttributes.screenName] = screenName;
    params[AWSEventAttributes.userId] = analyticsTrackerModel?.userId ?? "";
    params[AWSEventAttributes.email] = analyticsTrackerModel?.emailId ?? "";
    params[AWSEventAttributes.mobile] =
        analyticsTrackerModel?.contactNumer ?? "";
    if (analyticsTrackerModel?.searchAction != null) {
      params[AWSEventAttributes.searchAction] =
          analyticsTrackerModel?.searchAction ?? "";
    }
    if (analyticsTrackerModel?.searchAction != null) {
      params[AWSEventAttributes.keyword] =
          analyticsTrackerModel?.searchKeyword ?? "";
    }
    params[AWSEventAttributes.time] =
        DateTime.now().millisecondsSinceEpoch.toString();
    params[AWSEventAttributes.storeId] = analyticsTrackerModel?.storeId ?? "";
  }

  _setItemMapFromItemData(
      Map<String, String> params, AWSAnalyticsItemModel itemData) {
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.id )) {
      params[AWSEventAttributes.variantId] = itemData.id ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.name )) {
      params[AWSEventAttributes.itemName] = itemData.name ?? '';
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.categoryName )) {
      params[AWSEventAttributes.category] = itemData.categoryName ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.offerPrice )) {
      params[AWSEventAttributes.price] = itemData.offerPrice ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.quantity )) {
      params[AWSEventAttributes.quantity] = itemData.quantity ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.brand )) {
      params[AWSEventAttributes.brand] = itemData.brand ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.imageUrl )) {
      params[AWSEventAttributes.productImageUrl] = itemData.imageUrl ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.landingUrl )) {
      params[AWSEventAttributes.landingUrl] = itemData.landingUrl ?? "";
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.primaryAttributeName )) {
      params[AWSEventAttributes.primaryAttributeName] =
          itemData.primaryAttributeName ?? '';
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.primaryAttributeValue )) {
      params[AWSEventAttributes.primaryAttributeValue] =
          itemData.primaryAttributeValue ?? '';
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.secondaryAttributeName )) {
      params[AWSEventAttributes.secondaryAttributeName] =
          itemData.secondaryAttributeName ?? '';
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.secondaryAttributeValue )) {
      params[AWSEventAttributes.secondaryAttributeValue] =
          itemData.secondaryAttributeValue ?? '';
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.vendorName )) {
      params[AWSEventAttributes.vendorName] = itemData.vendorName ?? '';
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.catPre )) {
      params[AWSEventAttributes.catPrefix] = itemData.catPre ?? '';
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.secondaryCategory )) {
      params[AWSEventAttributes.itemSecondaryCategory] =
          itemData.secondaryCategory ?? '';
    }
    if (AnalyticsUtils.isNotNullOrEmpty(itemData.categoryId )) {
      params[AWSEventAttributes.categoryId] = itemData.categoryId ?? '';
    }
  }

  _getCartItemMapFromCartModel(
      Map<String, String> params, AWSAnalyticsCartModel cartModel) {
    List<String> itemNames = [];
    List<String> itemIDs = [];
    List<String> deliveryDates = [];
    List<String> productImageUrls = [];
    List<String> offerPrices = [];
    List<String> categories = [];
    List<String> brands = [];
    cartModel.items.forEach((element) {
      itemIDs.add(element.id ?? "-");
      itemNames.add(element.name ?? "-");
      deliveryDates.add(element.estimatedDeliveryDate ?? "-");
      productImageUrls.add(element.imageUrl ?? "-");
      offerPrices.add(element.offerPrice ?? "-");
      categories.add(element.categoryName ?? "-");
      brands.add(element.brand ?? "-");
    });

    params[AWSEventAttributes.itemId] = itemIDs.join(",");
    params[AWSEventAttributes.itemName] = itemNames.join(",");
    params[AWSEventAttributes.deliveryDate] = deliveryDates.join(",");
    params[AWSEventAttributes.productImageUrl] = productImageUrls.join(",");
    params[AWSEventAttributes.price] = offerPrices.join(",");
    params[AWSEventAttributes.category] = categories.join(",");
    params[AWSEventAttributes.brand] = brands.join(",");
  }

  Future<bool> recordsEvents(
      Map<String, String> eventParams, String eventName) async {
    try {
      Map arguments = Map();
      arguments['eventName'] = eventName;
      arguments['eventAttribute'] = eventParams;
      await methodChannel?.invokeMethod('recordEvent', arguments);
      return true;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
