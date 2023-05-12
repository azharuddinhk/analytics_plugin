enum AnalyticsPlaftorm { Android, iOS }

class AnalyticsItemModel {
  final String? id;
  final String? name;
  final double? offerPrice;
  final double? mrp;
  final num? discount;
  final String? categoryName;
  final int? quantity;
  final String? brand;
  final String? currency;
  final String? navKey;

  AnalyticsItemModel(
      {this.id,
      this.name,
      this.offerPrice,
      this.mrp,
      this.discount,
      this.categoryName,
      this.quantity,
      this.brand,
      this.currency,
      this.navKey});
}

class AnalyticsCartModel {
  final int? cartId;
  final String? shippingAddress;
  final List<AnalyticsItemModel>? items;
  final String? currency;
  final String? couponCode;
  final double? cartValue;
  final String? gatewayOrderId;
  final String? paymentType;
  final double? shippingCharge;

  AnalyticsCartModel(
      {this.cartId,
      this.shippingAddress,
      this.items,
      this.currency,
      this.couponCode,
      this.cartValue,
      this.gatewayOrderId,
      this.paymentType,
      this.shippingCharge});
}

class AnalyticsItemEventModel {
  String? userId;
  AnalyticsItemModel analyticsItemModel;
  AnalyticsItemEventModel({required this.analyticsItemModel, this.userId});
}

class AnalyticsUserModel {
  final String userId;
  final String userName;
  final String emailId;
  final String contactNumer;

  AnalyticsUserModel(
      this.userId, this.userName, this.emailId, this.contactNumer);
}
