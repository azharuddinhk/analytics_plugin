// import 'dart:async';
// class BranchManager {
//   static BranchManager _instance = BranchManager._();
//   static BranchManager get instance => _instance;
//   BranchManager._();
//   //StreamSubscription<Map>? streamSubscription;
//   //StreamController<String> controllerData = StreamController<String>();
//   void initializedBranch() {
//     // FlutterBranchSdk.validateSDKIntegration();
//     // listenDynamicLinks();
//   }
//
//   void listenDynamicLinks() async {
//     // streamSubscription = FlutterBranchSdk.initSession().listen((data) {
//     //   print('listenDynamicLinks - DeepLink Data: $data');
//     //   controllerData.sink.add((data.toString()));
//     //   if (data.containsKey('+clicked_branch_link') &&
//     //       data['+clicked_branch_link'] == true) {}
//     // }, onError: (error) {
//     //   print('InitSesseion error: ${error.toString()}');
//     // });
//   }
//
//   // void trackBranchEvent(List<BranchUniversalObject> items, BranchEvent event) {
//   //   //FlutterBranchSdk.trackContent(buo: items, branchEvent: event);
//   // }
//
//   void logPurchase(OrderSuccessResponseModel orderSuccess) {
//     // if (orderSuccess.cartModel != null &&
//     //     (orderSuccess.cartModel!.orderVariantList?.length ?? 0) > 0) {
//     //   List<BranchUniversalObject> items = [];
//     //   orderSuccess.cartModel!.orderVariantList!.forEach((element) {
//     //     items.add(getAnalyticsEventItemOrderProductWithQuantity(element));
//     //   });
//
//     //   BranchEvent event =
//     //       BranchEvent.standardEvent(BranchStandardEvent.PURCHASE);
//     //   event.transactionID = orderSuccess.gId ?? "";
//     //   event.currency = BranchCurrencyType.INR;
//     //   event.revenue = orderSuccess.cartModel?.totPay ?? 0;
//     //   event.shipping = orderSuccess.cartModel?.totShip ?? 0;
//     //   event.tax = 0;
//     //   event.coupon = orderSuccess.cartModel?.appliedCouponCode ?? "";
//     //   trackBranchEvent(items, event);
//     // }
//   }
//
//   logViewCart(CartModel cartModel) {
//     // List<BranchUniversalObject> items = getCartItemsFromCartModel(cartModel);
//     // BranchEvent event =
//     //     BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART);
//     // event.currency = BranchCurrencyType.INR;
//     // event.revenue = cartModel.totOffPr ?? 0;
//     // event.shipping = cartModel.totShip ?? 0;
//     // event.tax = 0;
//     // event.coupon = cartModel.appliedCouponCode ?? "";
//     // trackBranchEvent(items, event);
//   }
//
//   logBeginCheckout(PaymentModel paymentModel) async {
//     // if (paymentModel.cartModel != null) {
//     //   List<BranchUniversalObject> items =
//     //       getCartItemsFromCartModel(paymentModel.cartModel!);
//     //   BranchEvent event =
//     //       BranchEvent.standardEvent(BranchStandardEvent.INITIATE_PURCHASE);
//     //   event.currency = BranchCurrencyType.INR;
//     //   event.revenue = paymentModel.cartModel!.totPay ?? 0;
//     //   event.shipping = paymentModel.cartModel!.totShip ?? 0;
//     //   event.tax = 0;
//     //   event.coupon = paymentModel.cartModel!.appliedCouponCode ?? "";
//     //   trackBranchEvent(items, event);
//     // }
//   }
//
//   Future logAddToWishlistVariant(Variant data, int quantity) async {
//     // BranchEvent event =
//     //     BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_WISHLIST);
//     // event.currency = BranchCurrencyType.INR;
//     // trackBranchEvent(
//     //     [getAnalyticsEventVariantWithQuantity(data, quantity)], event);
//   }
//
//   logAddToCart(ProductDataModel data, int quantity) {
//     // BranchEvent event =
//     //     BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART);
//     // event.currency = BranchCurrencyType.INR;
//     // trackBranchEvent(
//     //     [getAnalyticsEventItemWithQuantity(data, quantity)], event);
//   }
// }
//
// // extension BranchEventHelper on BranchManager {
// //   BranchUniversalObject getAnalyticsEventItemWithQuantity(
// //       ProductDataModel product, int quantity,
// //       {bool isCart = false}) {
// //     BranchContentMetaData metaData = BranchContentMetaData();
// //     metaData.sku = isCart ? product.sv_id ?? "" : "${product.id ?? 0}";
// //     metaData.productName = isCart ? product.sv_nm ?? "" : product.nm ?? "";
// //     metaData.price =
// //         isCart ? product.totOffPr ?? 0.0 : product.offerPrice ?? 0.0;
// //     metaData.quantity = quantity.toDouble();
// //     metaData.productBrand = product.brand ?? "";
// //     metaData.productCategory = BranchProductCategory.HEALTH_AND_BEAUTY;
// //     metaData.currencyType = BranchCurrencyType.INR;
// //     metaData.contentSchema = BranchContentSchema.COMMERCE_PRODUCT;
// //     metaData.addCustomMetadata(
// //         MoEventAttributes.item_category, product.catName ?? "");
// //     return BranchUniversalObject(
// //         canonicalIdentifier: isCart ? product.sv_nm ?? "" : product.nm ?? "",
// //         contentMetadata: metaData);
// //   }
//
// //   BranchUniversalObject getAnalyticsEventItemOrderProductWithQuantity(
// //       OrderProductDataModel product) {
// //     BranchContentMetaData metaData = BranchContentMetaData();
// //     metaData.sku = "${product.svId ?? 0}";
// //     metaData.productName = product.svNm ?? "";
// //     metaData.price = product.totOffPr ?? 0.0;
// //     metaData.quantity = (product.quantity ?? 1).toDouble();
// //     metaData.productBrand = product.brand ?? "";
// //     metaData.productCategory = BranchProductCategory.HEALTH_AND_BEAUTY;
// //     metaData.currencyType = BranchCurrencyType.INR;
// //     metaData.contentSchema = BranchContentSchema.COMMERCE_PRODUCT;
// //     metaData.addCustomMetadata(
// //         MoEventAttributes.item_category, product.catName ?? "");
// //     return BranchUniversalObject(
// //         canonicalIdentifier: product.svNm ?? "", contentMetadata: metaData);
// //   }
//
// //   BranchUniversalObject getAnalyticsEventPackWithQuantity(
// //       CartPacks product, int quantity) {
// //     BranchContentMetaData metaData = BranchContentMetaData();
// //     metaData.sku = "${product.id ?? 0}";
// //     metaData.productName = product.pckName ?? "";
// //     metaData.price = product.totOffPr ?? 0.0;
// //     metaData.quantity = quantity.toDouble();
// //     metaData.productCategory = BranchProductCategory.HEALTH_AND_BEAUTY;
// //     metaData.currencyType = BranchCurrencyType.INR;
// //     metaData.contentSchema = BranchContentSchema.COMMERCE_PRODUCT;
// //     return BranchUniversalObject(
// //         canonicalIdentifier: product.pckName ?? "", contentMetadata: metaData);
// //   }
//
// //   BranchUniversalObject getAnalyticsEventVariantWithQuantity(
// //       Variant product, int quantity) {
// //     BranchContentMetaData metaData = BranchContentMetaData();
// //     metaData.sku = "${product.id ?? 0}";
// //     metaData.productName = product.nm ?? "";
// //     metaData.price = product.offerPr ?? 0.0;
// //     metaData.quantity = quantity.toDouble();
// //     metaData.productCategory = BranchProductCategory.HEALTH_AND_BEAUTY;
// //     metaData.currencyType = BranchCurrencyType.INR;
// //     metaData.contentSchema = BranchContentSchema.COMMERCE_PRODUCT;
// //     metaData.addCustomMetadata(
// //         MoEventAttributes.item_category, product.catName ?? "");
// //     return BranchUniversalObject(
// //         canonicalIdentifier: product.nm ?? "", contentMetadata: metaData);
// //   }
//
// //   List<BranchUniversalObject> getCartItemsFromCartModel(CartModel cartModel) {
// //     List<BranchUniversalObject> items = [];
// //     if (cartModel.variantList != null && cartModel.variantList!.length > 0) {
// //       cartModel.variantList!.forEach((element) {
// //         items.add(getAnalyticsEventItemWithQuantity(
// //             element, element.quantity ?? 1,
// //             isCart: true));
// //       });
// //     }
// //     if (cartModel.cartPacksList != null &&
// //         cartModel.cartPacksList!.length > 0) {
// //       cartModel.cartPacksList!.forEach((element) {
// //         items.add(getAnalyticsEventPackWithQuantity(element, element.qty ?? 1));
// //       });
// //     }
// //     return items;
// //   }
// // }
