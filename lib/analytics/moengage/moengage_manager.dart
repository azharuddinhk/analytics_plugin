// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// final tag = "MoEngageManager";
//
// class MoEngageManager {
//   static MoEngageManager _instance = MoEngageManager._();
//   final MoEngageFlutter _moEngagePlugin = MoEngageFlutter(MOENGAGE_APP_ID);
//   static MoEngageManager get instance => _instance;
//   MoEngageManager._();
//
//   void initializedMoEngage() {
//     if (RemoteConfig.instance.isMoengage()) {
//       _moEngagePlugin.setPushClickCallbackHandler(_onPushClick);
//       _moEngagePlugin.setInAppClickHandler(_onInAppClick);
//       _moEngagePlugin.setInAppShownCallbackHandler(_onInAppShown);
//       _moEngagePlugin.setInAppDismissedCallbackHandler(_onInAppDismiss);
//       // _moEngagePlugin.setSelfHandledInAppHandler(_onInAppSelfHandle);
//       _moEngagePlugin.setPushTokenCallbackHandler(_onPushTokenGenerated);
//       _moEngagePlugin.setPermissionCallbackHandler(_permissionCallbackHandler);
//       //_moEngagePlugin.configureLogs(LogLevel.VERBOSE);
//       _moEngagePlugin.initialise();
//       if (platform() == IOS) _moEngagePlugin.registerForPushNotification();
//       _isAppInstallOrUpdate();
//     }
//   }
//
//   void setMoEngagePushToken(String pushToken) {
//     if (RemoteConfig.instance.isMoengage()) {
//       if (platform() == ANDROID) _moEngagePlugin.passFCMPushToken(pushToken);
//     }
//   }
//
//   void setMoEngagePushPayload(RemoteMessage message) {
//     if (RemoteConfig.instance.isMoengage()) {
//       _moEngagePlugin.passFCMPushPayload(message.data);
//     }
//   }
//
//   void _onPushClick(PushCampaignData message) {
//     debugPrint(
//         "$tag Main : _onPushClick(): This is a push click callback from native to flutter. Payload " +
//             message.toString());
//   }
//
//   void _onInAppClick(ClickData message) {
//     debugPrint(
//         "$tag Main : _onInAppClick() : This is a inapp click callback from native to flutter. Payload " +
//             message.toString());
//   }
//
//   void _onInAppShown(InAppData message) {
//     debugPrint(
//         "$tag Main : _onInAppShown() : This is a callback on inapp shown from native to flutter. Payload " +
//             message.toString());
//   }
//
//   void _onInAppDismiss(InAppData message) {
//     debugPrint(
//         "$tag Main : _onInAppDismiss() : This is a callback on inapp dismiss from native to flutter. Payload " +
//             message.toString());
//   }
//
//   void _onPushTokenGenerated(PushTokenData pushToken) {
//     debugPrint(
//         "$tag Main : _onPushTokenGenerated() : This is callback on push token generated from native to flutter: PushToken: " +
//             pushToken.toString());
//   }
//
//   void _permissionCallbackHandler(PermissionResultData data) {
//     debugPrint("$tag Permission Result: " + data.toString());
//   }
//
//   void _isAppInstallOrUpdate() async {
//     if (RemoteConfig.instance.isMoengage()) {
//       final Tuple2 tuple =
//           await SharedPreference().isFirstLaunchAfterUpdateInstall();
//       if (tuple.item1) {
//         _moEngagePlugin.setAppStatus(
//             tuple.item2 ? MoEAppStatus.install : MoEAppStatus.update);
//         MBAnalyticsManager.instance.addEventsWithName(
//             tuple.item2 ? MBEventNames.APP_INSTALL : MBEventNames.APP_UPDATE,
//             isViewEvent: true);
//       }
//     }
//   }
//
//   void setUserAttribute(UserModel userModel) {
//     if (RemoteConfig.instance.isMoengage()) {
//       _moEngagePlugin.setUniqueId("${userModel.id ?? 0}");
//       if (userModel.nm != null) {
//         _moEngagePlugin.setUserName(userModel.nm ?? "");
//       }
//       if (userModel.email != null) {
//         _moEngagePlugin.setEmail(userModel.email ?? "");
//       }
//       if (userModel.cntNum != null) {
//         _moEngagePlugin.setPhoneNumber("91${userModel.cntNum!}");
//       }
//       DateTime now = DateTime.now();
//       String isoDate = now.toIso8601String();
//       _moEngagePlugin.setUserAttributeIsoDate("timeStamp", isoDate);
//     }
//   }
//
//   void resetUser() {
//     if (RemoteConfig.instance.isMoengage()) {
//       _moEngagePlugin.logout();
//     }
//   }
//
//   void trackEvents(String eventName, MoEProperties properties) {
//     if (RemoteConfig.instance.isMoengage()) {
//       String osVersion = Platform.operatingSystemVersion;
//       properties.addAttribute(
//           MBEventAttributes.platform, platform() == 3 ? "Android" : "iOS");
//       properties.addAttribute(
//           MBEventAttributes.version, SharedPreference().getVersionCode());
//       properties.addAttribute(MBEventAttributes.osVersion, osVersion);
//       properties.addAttribute(
//           MBEventAttributes.deviceName, MBAppSingleton.instance.deviceName);
//       _moEngagePlugin.trackEvent(eventName, properties);
//     }
//   }
//
//   setProductListViewEvent(ListingModel listingModel) async {
//     if (RemoteConfig.instance.isMoengage()) {
//       if (listingModel.list != null && listingModel.list!.length > 0) {
//         List<String> items = [];
//         listingModel.list!.forEach((element) {
//           items.add("${element.nm}||${element.id}||${element.offerPrice} ");
//         });
//         MoEProperties properties = MoEProperties();
//         properties.addAttribute(MoEventAttributes.items, items);
//         trackEvents(MOEventNames.VIEW_ITEM, properties);
//       }
//     }
//   }
//
//   logSelectItemViewEvent(ProductDataModel data) {
//     if (RemoteConfig.instance.isMoengage()) {
//       trackEvents(MOEventNames.SELECT_ITEM, getAnalyticsEventItem(data));
//     }
//   }
//
//   logItemViewEvent(ProductDataModel data) {
//     if (RemoteConfig.instance.isMoengage()) {
//       trackEvents(MOEventNames.VIEW_ITEM, getAnalyticsEventItem(data));
//     }
//   }
//
//   logAddToCart(ProductDataModel data, int quantity) async {
//     if (RemoteConfig.instance.isMoengage()) {
//       trackEvents(MOEventNames.ADD_TO_CART,
//           getAnalyticsEventItemWithQuantity(data, quantity));
//     }
//   }
//
//   logAddToWishlist(ProductDataModel data, int quantity) async {
//     if (RemoteConfig.instance.isMoengage()) {
//       trackEvents(MOEventNames.ADD_TO_WISHLIST,
//           getAnalyticsEventItemWithQuantity(data, quantity));
//     }
//   }
//
//   logRemoveFromCart(ProductDataModel data, int quantity) async {
//     if (RemoteConfig.instance.isMoengage()) {
//       trackEvents(MOEventNames.REMOVE_FROM_CART,
//           getAnalyticsEventItemWithQuantity(data, quantity, isCart: true));
//     }
//   }
//
//   logAddToWishlistVariant(Variant data, int quantity) async {
//     if (RemoteConfig.instance.isMoengage()) {
//       trackEvents(MOEventNames.ADD_TO_WISHLIST,
//           getAnalyticsEventVariantWithQuantity(data, quantity));
//     }
//   }
//
//   logViewCart(CartModel cartModel) {
//     if (RemoteConfig.instance.isMoengage()) {
//       List items = getCartItemsFromCartModel(cartModel);
//       MoEProperties properties = MoEProperties();
//       properties
//           .addAttribute(MoEventAttributes.items, items)
//           .addAttribute(MoEventAttributes.currency, "INR")
//           .addAttribute(MoEventAttributes.value, cartModel.totOffPr);
//       trackEvents(MOEventNames.VIEW_CART, properties);
//     }
//   }
//
//   logBeginCheckout(PaymentModel paymentModel) {
//     if (RemoteConfig.instance.isMoengage()) {
//       if (paymentModel.cartModel != null) {
//         List items = getCartItemsFromCartModel(paymentModel.cartModel!);
//         MoEProperties properties = MoEProperties();
//         properties
//             .addAttribute(MoEventAttributes.items, items)
//             .addAttribute(MoEventAttributes.currency, "INR")
//             .addAttribute(MoEventAttributes.coupon,
//                 paymentModel.cartModel!.appliedCouponCode)
//             .addAttribute(
//                 MoEventAttributes.value, paymentModel.cartModel!.totOffPr);
//         trackEvents(MOEventNames.BEGIN_CHECKOUT, properties);
//       }
//     }
//   }
//
//   logAddShippingInfo(PaymentModel model, AddressModel addressModel) async {
//     if (RemoteConfig.instance.isMoengage()) {
//       if (model.cartModel != null) {
//         List items = getCartItemsFromCartModel(model.cartModel!);
//         MoEProperties properties = MoEProperties();
//         properties
//             .addAttribute(MoEventAttributes.items, items)
//             .addAttribute(MoEventAttributes.currency, "INR")
//             .addAttribute(
//                 MoEventAttributes.coupon, model.cartModel!.appliedCouponCode)
//             .addAttribute(
//                 MoEventAttributes.shipping, addressModel.getCompleteAddress())
//             .addAttribute(MoEventAttributes.value, model.cartModel!.totOffPr);
//         trackEvents(MOEventNames.ADD_SHIPPING_INFO, properties);
//       }
//     }
//   }
//
//   logPurchase(OrderSuccessResponseModel orderSuccess) {
//     if (RemoteConfig.instance.isMoengage()) {
//       if (orderSuccess.cartModel != null) {
//         List items = getOrderItemsFromOrderModel(orderSuccess);
//         MoEProperties properties = MoEProperties();
//         properties
//             .addAttribute(MoEventAttributes.items, items)
//             .addAttribute(MoEventAttributes.currency, "INR")
//             .addAttribute(MoEventAttributes.coupon,
//                 orderSuccess.cartModel!.appliedCouponCode)
//             .addAttribute(MoEventAttributes.shippingCharge,
//                 orderSuccess.cartModel?.totShip)
//             .addAttribute(
//                 MoEventAttributes.value, orderSuccess.cartModel?.totPay)
//             .addAttribute(MoEventAttributes.transaction_id, orderSuccess.gId);
//         trackEvents(MOEventNames.PURCHASE, properties);
//       }
//     }
//   }
// }
//
// extension MoEngageEventHelper on MoEngageManager {
//   MoEProperties getAnalyticsEventItem(ProductDataModel product) {
//     MoEProperties params = MoEProperties();
//     params
//         .addAttribute(MoEventAttributes.item_id, "${product.id ?? 0}")
//         .addAttribute(MoEventAttributes.item_name, product.nm ?? "")
//         .addAttribute(MoEventAttributes.item_category, product.catName ?? "")
//         .addAttribute(MoEventAttributes.item_brand, product.brand ?? "")
//         .addAttribute(MoEventAttributes.price, product.offerPrice);
//     return params;
//   }
//
//   MoEProperties getAnalyticsEventItemWithQuantity(
//       ProductDataModel product, int quantity,
//       {bool isCart = false}) {
//     MoEProperties params = MoEProperties();
//     params
//         .addAttribute(MoEventAttributes.item_id,
//             isCart ? product.sv_id : "${product.id ?? 0}")
//         .addAttribute(MoEventAttributes.item_name,
//             isCart ? product.sv_nm : product.nm ?? "")
//         .addAttribute(MoEventAttributes.item_category, product.catName ?? "")
//         .addAttribute(MoEventAttributes.item_brand, product.brand ?? "")
//         .addAttribute(MoEventAttributes.price,
//             isCart ? product.totOffPr : product.offerPrice)
//         .addAttribute(MoEventAttributes.quantity, quantity);
//     return params;
//   }
//
//   MoEProperties getAnalyticsEventVariantWithQuantity(
//       Variant product, int quantity) {
//     MoEProperties params = MoEProperties();
//     params
//         .addAttribute(MoEventAttributes.item_id, "${product.id ?? 0}")
//         .addAttribute(MoEventAttributes.item_name, product.nm ?? "")
//         .addAttribute(MoEventAttributes.item_category, product.catName ?? "")
//         .addAttribute(MoEventAttributes.item_brand, product.brand ?? "")
//         .addAttribute(MoEventAttributes.price, product.offerPr)
//         .addAttribute(MoEventAttributes.quantity, quantity);
//     return params;
//   }
//
//   List getCartItemsFromCartModel(CartModel cartModel) {
//     List items = [];
//     if (cartModel.variantList != null && cartModel.variantList!.length > 0) {
//       cartModel.variantList!.forEach((element) {
//         items.add("${element.sv_nm}||${element.sv_id}||${element.totOffPr} ");
//       });
//     }
//     if (cartModel.cartPacksList != null &&
//         cartModel.cartPacksList!.length > 0) {
//       cartModel.cartPacksList!.forEach((element) {
//         items.add("${element.id}||${element.pckName}||${element.totOffPr} ");
//       });
//     }
//     return items;
//   }
//
//   List getOrderItemsFromOrderModel(OrderSuccessResponseModel orderSuccess) {
//     List items = [];
//     if (orderSuccess.cartModel?.orderVariantList != null) {
//       orderSuccess.cartModel?.orderVariantList!.map((e) =>
//           items.add("${e.svNm}||${e.svId}||${e.totOffPr}||${e.quantity} "));
//     }
//     return items;
//   }
// }
