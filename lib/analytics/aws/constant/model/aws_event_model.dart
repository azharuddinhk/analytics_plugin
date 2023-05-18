enum AWSAnalyticsPlaftorm { Android, Apple }

class AWSAnalyticsItemModel {
  final String? id;
  final String? name;
  final String? offerPrice;
  final String? categoryName;
  final String? quantity;
  final String? brand;
  final String? imageUrl;
  final String? landingUrl;
  final String? primaryAttributeName;
  final String? primaryAttributeValue;
  final String? secondaryAttributeName;
  final String? secondaryAttributeValue;
  final String? vendorName;
  final String? catPre;
  final String? estimatedDeliveryDate;
  final String? secondaryCategory;
  final String? categoryId;

  AWSAnalyticsItemModel(
      {this.imageUrl,
      this.landingUrl,
      this.primaryAttributeName,
      this.primaryAttributeValue,
      this.secondaryAttributeName,
      this.secondaryAttributeValue,
      this.vendorName,
      this.catPre,
      this.id,
      this.name,
      this.offerPrice,
      this.categoryName,
      this.quantity,
      this.brand,
      this.estimatedDeliveryDate,
      this.categoryId,
      this.secondaryCategory});
}

class AWSAnalyticsItemEventModel {
  final String? eventType;
  final String? eventName;
  final String? widgetPosition;
  final String? itemPosition;
  final String? widgetName;
  AWSAnalyticsItemModel analyticsItem;

  final String? urlFragment;
  final String? keyword;
  final String? searchAction;
  final String? filterType;
  final String? filterValue;

  AWSAnalyticsItemEventModel(
      {this.eventType,
      this.eventName,
      this.widgetPosition,
      this.itemPosition,
      this.widgetName,
      this.urlFragment,
      this.keyword,
      this.searchAction,
      this.filterType,
      this.filterValue,
      required this.analyticsItem});
}

class AWSAnalyticsCartModel {
  final String? cartId;
  final String? shippingAddress;
  final List<AWSAnalyticsItemModel> items;
  final String? currency;
  final String? couponCode;
  final String? cartValue;
  final String? gatewayOrderId;
  final String? paymentType;
  final String? shippingCharge;
  final String? eventType;
  final String? eventName;
  final String? pincode;
  final String? numberOfItems;

  AWSAnalyticsCartModel(
      {this.cartId,
      this.shippingAddress,
      required this.items,
      this.currency,
      this.couponCode,
      this.cartValue,
      this.gatewayOrderId,
      this.paymentType,
      this.shippingCharge,
      this.eventType,
      this.pincode,
      this.numberOfItems,
      this.eventName});
}

class AWSAnalyticsTrackerModel {
  final String? deviceId;
  final String? deviceName;
  final String? appVersion;
  final String? currentDate;
  final AWSAnalyticsPlaftorm? plaftorm;
  String? userId;
  String? emailId;
  String? contactNumer;
  String? storeId;
  String? searchAction;
  String? searchKeyword;

  AWSAnalyticsTrackerModel(this.currentDate,
      {this.deviceId,
      this.deviceName,
      this.appVersion,
      this.plaftorm,
      this.userId,
      this.emailId,
      this.contactNumer,
      this.storeId,
      this.searchAction,
      this.searchKeyword});

  setUserDetail(String userId, String emailId, String contactNumber) {
    userId = userId;
    emailId = emailId;
    contactNumer = contactNumer;
  }

  setSearchData(String searchAction, String searchKeyword) {
    searchAction = searchAction;
    searchKeyword = searchKeyword;
  }
}
