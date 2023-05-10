// import 'dart:core';
//
// import 'package:analytics_plugin/analytics/constant/mb_event_attributes.dart';
// import 'package:analytics_plugin/analytics/constant/mb_event_name.dart';
// import 'package:analytics_plugin/analytics/model/page_section_event_dto.dart';
// import 'package:analytics_plugin/analytics/rudderstack/rudder_stack_event.dart';
//
// class RudderStackManager {
//   static RudderStackManager _instance = RudderStackManager._();
//   static RudderStackManager get instance => _instance;
//   RudderStackManager._();
//
//   registerUser(UserModel userModel) {
//     RudderStackEvent.instance.registerUser(userModel);
//   }
//
//   resetUser() {
//     RudderStackEvent.instance.resetUser();
//   }
//
//   setSingleAttributeEvent(
//       {required String eventName, required String key, required String value}) {
//     Map<String, dynamic> params = Map<String, dynamic>();
//     params[key] = value;
//     RudderStackEvent.instance.trackEvents(eventName, params);
//   }
//
//   setEventWithAttrinutes(String eventName, Map<String, dynamic> attributes) {
//     RudderStackEvent.instance.trackEvents(eventName, attributes);
//   }
//
//   setProductListViewEvent(ListingModel listingModel) {
//     List<Map<String, dynamic>> items = [];
//     String categoryName = "";
//     if (listingModel.list != null && listingModel.list!.isNotEmpty) {
//       for (int i = 0; i < listingModel.list!.length; i++) {
//         ProductDataModelModel model = listingModel.list![i];
//         categoryName = model.catName ?? "";
//         Map<String, dynamic> productMap =
//             _productMapFromProductDataModel(model, 0, false);
//         productMap[MBEventAttributes.position] = i + 1;
//         items.add(productMap);
//         if (i == 3) {
//           break;
//         }
//       }
//       Map<String, dynamic> params = Map<String, dynamic>();
//       params[MBEventAttributes.products] = items;
//       params[MBEventAttributes.category] = categoryName;
//       params[MBEventAttributes.category] = categoryName;
//       RudderStackEvent.instance
//           .trackEvents(MBEventNames.PRODUCT_LIST_VIEW, params);
//     }
//   }
//
//   setProductEvent(String eventName, ProductDataModelModel model,
//       {int? itemPosition, int quantity = 0, bool isCart = false}) {
//     Map<String, dynamic> params =
//         _productMapFromProductDataModel(model, quantity, isCart);
//     if (itemPosition != null) {
//       params[MBEventAttributes.position] = itemPosition;
//     }
//     RudderStackEvent.instance.trackEvents(eventName, params);
//   }
//
//   setWishlistAddtoCartEvent(Variant varient, int quantity) {
//     Map<String, dynamic> params = _variantMapFromVariant(varient, quantity);
//     RudderStackEvent.instance
//         .trackEvents(MBEventNames.WISHLIST_PRODUCT_ADDED_TO_CART, params);
//   }
//
//   setCartViewEvent(CartModel cartModel) {
//     List<Map<String, dynamic>> items = [];
//     if (cartModel.variantList != null) {
//       cartModel.variantList!.forEach((element) {
//         items.add(
//             _productMapFromProductDataModel(element, element.quantity ?? 0, true));
//       });
//     }
//     if (cartModel.cartPacksList != null) {
//       cartModel.cartPacksList!.forEach((element) {
//         items.add(_productMapFromCartPack(element, element.qty ?? 1));
//       });
//     }
//     Map<String, dynamic> params = Map<String, dynamic>();
//     params[MBEventAttributes.cartId] = cartModel.cartId ?? 0;
//     params[MBEventAttributes.products] = items;
//     RudderStackEvent.instance.trackEvents(MBEventNames.CART_VIEW, params);
//   }
//
//   checkoutStartedEvent(PaymentModel paymentModel) {
//     List<Map<String, dynamic>> items = [];
//     if (paymentModel.cartModel?.variantList != null) {
//       paymentModel.cartModel?.variantList!.forEach((element) {
//         items.add(
//             _productMapFromProductDataModel(element, element.quantity ?? 0, true));
//       });
//     }
//     if (paymentModel.cartModel?.cartPacksList != null) {
//       paymentModel.cartModel?.cartPacksList!.forEach((element) {
//         items.add(_productMapFromCartPack(element, element.qty ?? 1));
//       });
//     }
//
//     Map<String, dynamic> params = Map<String, dynamic>();
//     params[MBEventAttributes.cartId] = paymentModel.cartModel?.cartId ?? 0;
//     params[MBEventAttributes.products] = items;
//     params[MBEventAttributes.affiliation] = "";
//     params[MBEventAttributes.value] = paymentModel.cartModel?.totOffPr ?? 0;
//     params[MBEventAttributes.revenue] = paymentModel.cartModel?.totOffPr ?? 0;
//     params[MBEventAttributes.shipping] = paymentModel.cartModel?.totShip ?? 0;
//     params[MBEventAttributes.tax] = 0;
//     params[MBEventAttributes.discount] =
//         paymentModel.cartModel?.newStoreDiscount ?? 0;
//     params[MBEventAttributes.coupon] =
//         paymentModel.cartModel?.appliedCouponCode;
//     params[MBEventAttributes.currency] = MBEventAttributes.currencyValue;
//     RudderStackEvent.instance.trackEvents(MBEventNames.CHEKOUT_STARTED, params);
//   }
//
//   submitProductReview(int productId, String reviewDescription, int rating) {
//     Map<String, dynamic> params = Map<String, dynamic>();
//     params[MBEventAttributes.product_id] = productId;
//     params[MBEventAttributes.reviewId] = "";
//     params[MBEventAttributes.rating] = rating;
//     params[MBEventAttributes.reviewBody] = reviewDescription;
//     RudderStackEvent.instance
//         .trackEvents(MBEventNames.PRODUCT_REVIEWED, params);
//   }
//
//   submitPurchaseEvent(OrderSuccessResponseModel orderSuccess) {
//     List<Map<String, dynamic>> items = [];
//     if (orderSuccess.cartModel?.orderVariantList != null) {
//       orderSuccess.cartModel?.orderVariantList!.forEach((element) {
//         items.add(_productMapFromOrderProduct(element));
//       });
//     }
//
//     Map<String, dynamic> params = Map<String, dynamic>();
//     params[MBEventAttributes.checkoutId] = "";
//     params[MBEventAttributes.orderId] = orderSuccess.gId;
//     params[MBEventAttributes.products] = items;
//     params[MBEventAttributes.affiliation] = "";
//     params[MBEventAttributes.total] = orderSuccess.cartModel?.totOffPr ?? 0;
//     params[MBEventAttributes.value] = orderSuccess.cartModel?.totOffPr ?? 0;
//     params[MBEventAttributes.revenue] = orderSuccess.cartModel?.totOffPr ?? 0;
//     params[MBEventAttributes.shipping] = orderSuccess.cartModel?.totShip ?? 0;
//     params[MBEventAttributes.tax] = 0;
//     params[MBEventAttributes.discount] =
//         orderSuccess.cartModel?.newStoreDiscount ?? 0;
//     params[MBEventAttributes.coupon] =
//         orderSuccess.cartModel?.appliedCouponCode;
//     params[MBEventAttributes.currency] = MBEventAttributes.currencyValue;
//     RudderStackEvent.instance.trackEvents(MBEventNames.ORDER_COMPLETED, params);
//   }
// }
//
// extension RudderStackManagerHelper on RudderStackManager {
//   Map<String, dynamic> _productMapFromProductDataModel(
//       ProductDataModel ProductDataModel, int quantity, bool isCart) {
//     Map<String, dynamic> eventParams = Map();
//     eventParams[MBEventAttributes.product_id] = ProductDataModel.id ?? 0;
//     eventParams[MBEventAttributes.category] = ProductDataModel.catName ?? "";
//     eventParams[MBEventAttributes.name] = ProductDataModel.nm ?? "";
//     eventParams[MBEventAttributes.price] =
//         isCart ? ProductDataModel.totOffPr ?? 0 : ProductDataModel.offerPrice ?? 0;
//     eventParams[MBEventAttributes.quantity] = quantity;
//     eventParams[MBEventAttributes.currency] = MBEventAttributes.currencyValue;
//     eventParams[MBEventAttributes.urlWeb] = "";
//     eventParams[MBEventAttributes.image_url] =
//         ProductDataModel.imageModel?.mLink ?? "";
//     eventParams[MBEventAttributes.sku] = "";
//     eventParams[MBEventAttributes.brand] = "";
//     eventParams[MBEventAttributes.variant] = "";
//     eventParams[MBEventAttributes.coupon] = "";
//     return eventParams;
//   }
//
//   Map<String, dynamic> _productMapFromCartPack(CartPacks pack, int quantity) {
//     Map<String, dynamic> eventParams = Map();
//     eventParams[MBEventAttributes.product_id] = pack.id ?? 0;
//     eventParams[MBEventAttributes.category] = "";
//     eventParams[MBEventAttributes.name] = pack.pckName ?? "";
//     eventParams[MBEventAttributes.price] = pack.totOffPr ?? 0;
//     eventParams[MBEventAttributes.quantity] = quantity;
//     eventParams[MBEventAttributes.currency] = MBEventAttributes.currencyValue;
//     eventParams[MBEventAttributes.urlWeb] = "";
//     eventParams[MBEventAttributes.image_url] = pack.pckimage?.sLink ?? "";
//     eventParams[MBEventAttributes.sku] = "";
//     eventParams[MBEventAttributes.brand] = "";
//     eventParams[MBEventAttributes.variant] = "";
//     eventParams[MBEventAttributes.coupon] = "";
//     return eventParams;
//   }
//
//   Map<String, dynamic> _productMapFromOrderProduct(
//       OrderProductDataModel ProductDataModel) {
//     Map<String, dynamic> eventParams = Map();
//     eventParams[MBEventAttributes.product_id] = ProductDataModel.svId ?? 0;
//     eventParams[MBEventAttributes.category] = ProductDataModel.catName ?? "";
//     eventParams[MBEventAttributes.name] = ProductDataModel.svNm ?? "";
//     eventParams[MBEventAttributes.price] = ProductDataModel.totOffPr ?? 0;
//     eventParams[MBEventAttributes.quantity] = ProductDataModel.quantity ?? 1;
//     eventParams[MBEventAttributes.currency] = MBEventAttributes.currencyValue;
//     eventParams[MBEventAttributes.urlWeb] = "";
//     eventParams[MBEventAttributes.image_url] =
//         ProductDataModel.imageModel?.mLink ?? "";
//     eventParams[MBEventAttributes.sku] = "";
//     eventParams[MBEventAttributes.brand] = "";
//     eventParams[MBEventAttributes.variant] = "";
//     eventParams[MBEventAttributes.coupon] = "";
//     return eventParams;
//   }
//
//   Map<String, dynamic> _variantMapFromVariant(Variant variant, int quantity) {
//     Map<String, dynamic> eventParams = Map();
//     eventParams[MBEventAttributes.product_id] = variant.spId ?? "";
//     eventParams[MBEventAttributes.category] = variant.catName ?? "";
//     eventParams[MBEventAttributes.name] = variant.spName ?? "";
//     eventParams[MBEventAttributes.price] = variant.offerPr ?? 0;
//     eventParams[MBEventAttributes.quantity] = quantity;
//     eventParams[MBEventAttributes.currency] = MBEventAttributes.currencyValue;
//     eventParams[MBEventAttributes.urlWeb] = "";
//     eventParams[MBEventAttributes.image_url] = "";
//     eventParams[MBEventAttributes.sku] = "";
//     eventParams[MBEventAttributes.brand] = variant.brName ?? "";
//     eventParams[MBEventAttributes.variant] = "";
//     eventParams[MBEventAttributes.coupon] = "";
//     return eventParams;
//   }
// }
