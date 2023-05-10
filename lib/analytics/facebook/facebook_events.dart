import 'package:analytics_plugin/analytics/constant/fb_event_attributes.dart';
import 'package:analytics_plugin/analytics/model/event_model.dart';
import 'package:analytics_plugin/utils/BLChannelInvocation.dart';

class FBEventManager {
  static FBEventManager _instance = FBEventManager._();

  static FBEventManager get instance => _instance;

  FBEventManager._();
  
  logEvents(String name, Map<String, dynamic> attributes) {
    BLChannelInvocation.instance.recordFacebookEvents(attributes, name);
  }

  addToCart(ItemModel itemModel) {
    final navKey = itemModel.navKey ?? "";
    final itemName = itemModel.name ?? "";
    final brandName = itemModel.brand ?? "";
    final itemCategory = itemModel.categoryName?? "";
    var contentParams = Map<String, dynamic>();
    contentParams = {
      "Product Name": itemName,
      "Brand Name": brandName,
      "Category Name": itemCategory,
      "item_category": itemCategory,
      "item_name": itemName,
      "item_brand": brandName,
      "item_id": itemModel.id ?? 0,
    };

    Map<String, dynamic> fbParams = Map();
    fbParams[FBEventAttributes.paramNameContent] = contentParams;
    fbParams[FBEventAttributes.paramNameContentId] = navKey;
    fbParams[FBEventAttributes.paramNameContentType] =
        navKey.contains("PA-") ? "pack" : "product";
    fbParams[FBEventAttributes.paramNameCurrency] =
        itemModel.currency;
    fbParams[FBEventAttributes.paramNameValueToSum] =
        itemModel.offerPrice ?? 0.0;
    BLChannelInvocation.instance
        .recordFacebookEvents(fbParams, FBEventName.eventNameAddedToCart);
  }

  addToWishlist(ItemEventModel eventModel) {
    final navKey = eventModel.itemModel.navKey ?? "";
    final itemName = eventModel.itemModel.name ?? "";
    final brandName = eventModel.itemModel.brand ?? "";
    final itemCategory = eventModel.itemModel.categoryName ?? "";
    final id = eventModel.itemModel.id ?? 0;
    var contentParams = Map<String, dynamic>();
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

    Map<String, dynamic> fbParams = Map();
    fbParams[FBEventAttributes.paramNameContent] = contentParams;
    fbParams[FBEventAttributes.paramNameContentId] = navKey;
    fbParams[FBEventAttributes.paramNameContentType] =
        navKey.contains("PA-") ? "pack" : "product";
    fbParams[FBEventAttributes.paramNameCurrency] =
        eventModel.itemModel.currency;
    fbParams[FBEventAttributes.paramNameValueToSum] =
        eventModel.itemModel.offerPrice ?? 0.0;
    BLChannelInvocation.instance
        .recordFacebookEvents(fbParams, FBEventName.eventNameAddedToWishlist);
  }

  initiateCheckout(CartModel cartModel) {
    Map<String, dynamic> fbParams = Map();
    fbParams[FBEventAttributes.paramNameNumItems] =
        (cartModel.items?.length ?? 0) ;
    fbParams[FBEventAttributes.paramNameCurrency] =
        cartModel.currency;
    fbParams[FBEventAttributes.paramNameValueToSum] =
       cartModel.cartValue ?? 0.0;
    BLChannelInvocation.instance
        .recordFacebookEvents(fbParams, FBEventName.eventNameInitiatedCheckout);
  }

  purchaseEvents(CartModel cartModel) {
    var fbParams = Map<String, dynamic>();
    fbParams[FBEventAttributes.paramNameNumItems] =
        (cartModel.items?.length ?? 0);
    fbParams[FBEventAttributes.paramNameCurrency] =
        cartModel.currency;
    fbParams[FBEventAttributes.paramNameValueToSum] =
        cartModel.cartValue ?? 0.0;
    BLChannelInvocation.instance.recordFacebookEvents(fbParams, "Purchase");
  }

  viewItemEvent(ItemEventModel eventModel) {
    final navKey = eventModel.itemModel.navKey ?? "";
    final itemName = eventModel.itemModel.name ?? "";
    final brandName = eventModel.itemModel.brand ?? "";
    final itemCategory = eventModel.itemModel.categoryName ?? "";
    final id = eventModel.itemModel.id ?? 0;

    var contentParams = Map<String, dynamic>();
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
    Map<String, dynamic> fbParams = Map();
    fbParams[FBEventAttributes.paramNameContent] = contentParams;
    fbParams[FBEventAttributes.paramNameContentId] = navKey;
    fbParams[FBEventAttributes.paramNameContentType] =
        navKey.contains("PA-") ? "pack" : "product";
    fbParams[FBEventAttributes.paramNameCurrency] =
        eventModel.itemModel.currency;
    fbParams[FBEventAttributes.paramNameValueToSum] =
        eventModel.itemModel.offerPrice ?? 0.0;
    BLChannelInvocation.instance
        .recordFacebookEvents(fbParams, FBEventName.eventNameViewedContent);
  }
}
