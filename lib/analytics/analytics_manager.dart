import 'package:analytics_plugin/analytics/firebase/firebase_events.dart';
import 'package:analytics_plugin/analytics/model/event_model.dart';

class AnalyticsManager{
  static AnalyticsManager analytics = AnalyticsManager.instance;
  static late AnalyticsManager firebaseEvent;
  AnalyticsManager._privateConstructor();
  static final AnalyticsManager instance =   AnalyticsManager._privateConstructor();
  factory AnalyticsManager() {
    return instance;
  }

   logSelectItemViewEvent(ItemModel itemModel){
      FirebaseEvent.instance.logSelectItemViewEvent(itemModel);
   }

   setProductListViewEvent(List<ItemModel> list)  {
      FirebaseEvent.instance.setProductListViewEvent(list);
   }

    logItemViewEvent(ItemModel itemModel)  {
      FirebaseEvent.instance.logItemViewEvent(itemModel);
   }

    logAddToCart(ItemModel itemModel) {
      FirebaseEvent.instance.logAddToCart(itemModel);
   }

    logRemoveFromCart(ItemModel itemModel) {
      FirebaseEvent.instance.logRemoveFromCart(itemModel);
   }

    logAddToWishlist(ItemModel itemModel) {
      FirebaseEvent.instance.logAddToWishlist(itemModel);
   }


    logViewCart(CartModel cartModel) {
      FirebaseEvent.instance.logViewCart(cartModel);
   }

    logBeginCheckout(CartModel cartModel) {
      FirebaseEvent.instance.logBeginCheckout(cartModel);
   }

    logAddShippingInfo(
       CartModel cartModel) {
      FirebaseEvent.instance.logAddShippingInfo(cartModel);
   }

    logPurchase(CartModel cartModel) {
      FirebaseEvent.instance.logPurchase(cartModel);
   }

    logAddPaymentInfo(CartModel cartModel) {
      FirebaseEvent.instance.logAddPaymentInfo(cartModel);
   }
}