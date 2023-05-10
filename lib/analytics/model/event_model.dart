class ItemModel{
  int? id;
  String? name;
  double? offerPrice;
  double? mrp;
  num? discount;
  String? categoryName;
  int? quantity;
  String? brand;
  String? currency;
  String? navKey;
}

class CartModel {
  int? cartId;
  String? shippingAddress;
  List<ItemModel>? items;
  String? currency;
  String? couponCode;
  double? cartValue;
  String? gatewayOrderId;
  String? paymentType;
  double? shippingCharge;
}

class ItemEventModel{
      String? userId;
      ItemModel itemModel;
      ItemEventModel({ required this.itemModel , this.userId });
}