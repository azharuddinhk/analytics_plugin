class FBEventAttributes {
  FBEventAttributes._();

  static const paramNameValueToSum = "_valueToSum";
  static const paramNameAdType = "fb_ad_type";
  static const paramNameCurrency = "fb_currency";
  static const paramNameOrderId = "fb_order_id";
  static const paramValuetoSum = "value";
  static const paramNameRegistrationMethod = "fb_registration_method";
  static const paramNamePaymentInfoAvailable = "fb_payment_info_available";
  static const paramNameNumItems = "fb_num_items";
  static const paramValueYes = "1";
  static const paramValueNo = "0";
  static const paramNameContentType = "fb_content_type";
  static const paramNameContent = "fb_content";
  static const paramNameContentId = "fb_content_id";
}

class FBEventName {
  FBEventName._();
  static const eventNameCompletedRegistration =
      'fb_mobile_complete_registration';
  static const eventNameViewedContent = 'fb_mobile_content_view';
  static const eventNameRated = 'fb_mobile_rate';
  static const eventNameInitiatedCheckout = 'fb_mobile_initiated_checkout';
  static const eventNameAddedToCart = 'fb_mobile_add_to_cart';
  static const eventNameAddedToWishlist = 'fb_mobile_add_to_wishlist';
  static const eventNameSubscribe = "Subscribe";
  static const eventNameStartTrial = "StartTrial";
  static const eventNameAdImpression = "AdImpression";
  static const eventNameAdClick = "AdClick";
}
