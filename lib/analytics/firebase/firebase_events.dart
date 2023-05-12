import 'package:analytics_plugin/analytics/constant/mo_event_attributes.dart';
import 'package:analytics_plugin/analytics/model/event_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseEvent {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  static late FirebaseEvent firebaseEvent;

  FirebaseEvent._privateConstructor();

  static final FirebaseEvent instance = FirebaseEvent._privateConstructor();

  factory FirebaseEvent() {
    return instance;
  }

  Future recordScreenView(String screenName) async {
    await FirebaseAnalytics.instance.setCurrentScreen(screenName: screenName);
  }

  Future setLogin() async {
    await analytics.logLogin(
      loginMethod: "phone",
    );
  }

  Future setSignUp() async {
    await analytics.logSignUp(signUpMethod: "phone");
  }

  Future logSelectItemViewEvent(AnalyticsItemModel analyticsItemModel) async {
    List<AnalyticsEventItem> items = [];
    items.add(getAnalyticsEventItem(analyticsItemModel));
    await analytics.logSelectItem(
        items: items, itemListName: analyticsItemModel.categoryName ?? "");
  }

  Future setProductListViewEvent(List<AnalyticsItemModel> list) async {
    final items = list.map((e) => getAnalyticsEventItem(e)).toList();
    await analytics.logViewItemList(items: items, itemListName: "");
  }

  Future logItemViewEvent(AnalyticsItemModel analyticsItemModel) async {
    final items = [analyticsItemModel].map((e) => getAnalyticsEventItem(e)).toList();
    await analytics.logViewItem(
        items: items,
        currency: MoEventAttributes.currencyValue,
        value: analyticsItemModel.offerPrice);
  }

  Future logAddToCart(AnalyticsItemModel analyticsItemModel) async {
    final items = [analyticsItemModel].map((e) => getAnalyticsEventItem(e)).toList();
    logItemViewEvent(analyticsItemModel);
    await analytics.logAddToCart(
        items: items,
        currency: MoEventAttributes.currencyValue,
        value: (analyticsItemModel.offerPrice ?? 0) * (analyticsItemModel.quantity ?? 1));
  }

  Future logRemoveFromCart(AnalyticsItemModel analyticsItemModel) async {
    final items = [analyticsItemModel].map((e) => getAnalyticsEventItem(e)).toList();
    await analytics.logRemoveFromCart(
        items: items,
        currency: MoEventAttributes.currencyValue,
        value: (analyticsItemModel.offerPrice ?? 0) * (analyticsItemModel.quantity ?? 1));
  }

  Future logAddToWishlist(AnalyticsItemModel analyticsItemModel) async {
    final items = [analyticsItemModel].map((e) => getAnalyticsEventItem(e)).toList();
    await analytics.logAddToWishlist(
        items: items,
        currency: analyticsItemModel.currency,
        value: (analyticsItemModel.offerPrice ?? 0) * (analyticsItemModel.quantity ?? 1));
  }

  Future logAddToWishlistVariant(AnalyticsItemModel analyticsItemModel) async {
    final items = [analyticsItemModel].map((e) => getAnalyticsEventItem(e)).toList();
    await analytics.logAddToWishlist(
      items: items,
      currency: MoEventAttributes.currencyValue,
      value: (analyticsItemModel.offerPrice ?? 0) * (analyticsItemModel.quantity ?? 1),
    );
  }

  Future logViewCart(AnalyticsCartModel cartModel) async {
    final items =
        cartModel.items?.map((e) => getAnalyticsEventItem(e)).toList();
    await analytics.logViewCart(
        items: items, currency: cartModel.currency, value: cartModel.cartValue);
  }

  Future logBeginCheckout(AnalyticsCartModel cartModel) async {
    final items =
        cartModel.items?.map((e) => getAnalyticsEventItem(e)).toList();
    await analytics.logBeginCheckout(
        items: items,
        coupon: cartModel.couponCode,
        currency: cartModel.currency,
        value: cartModel.cartValue);
  }

  Future logAddShippingInfo(AnalyticsCartModel cartModel) async {
    final items =
        cartModel.items?.map((e) => getAnalyticsEventItem(e)).toList();
    await analytics.logAddShippingInfo(
        items: items,
        coupon: cartModel.couponCode,
        currency: cartModel.currency,
        shippingTier: cartModel.shippingAddress,
        value: cartModel.cartValue);
  }

  Future logPurchase(AnalyticsCartModel cartModel) async {
    final items =
        cartModel.items?.map((e) => getAnalyticsEventItem(e)).toList();
    await analytics.logPurchase(
      transactionId: cartModel.gatewayOrderId,
      affiliation: "",
      items: items,
      currency: MoEventAttributes.currencyValue,
      value: cartModel.cartValue,
      shipping: cartModel.shippingCharge,
      tax: 0,
      coupon: cartModel.couponCode,
    );
  }

  Future logAddPaymentInfo(AnalyticsCartModel cartModel) async {
    final items =
        cartModel.items?.map((e) => getAnalyticsEventItem(e)).toList();
    await analytics.logAddPaymentInfo(
      coupon: cartModel.couponCode,
      currency: cartModel.currency,
      paymentType: cartModel.paymentType,
      value: cartModel.cartValue,
      items: items,
    );
  }
}

extension FirebaseEventHelper on FirebaseEvent {
  AnalyticsEventItem getAnalyticsEventItem(AnalyticsItemModel product) {
    return AnalyticsEventItem(
        itemId: "${product.id ?? 0}",
        itemName: product.name ?? "",
        itemCategory: product.categoryName ?? "",
        itemVariant: "",
        itemBrand: product.brand ?? "MuscleBlaze",
        price: product.offerPrice,
        quantity: product.quantity ?? 1);
  }
}
