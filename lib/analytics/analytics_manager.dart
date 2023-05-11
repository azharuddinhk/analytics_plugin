import 'package:analytics_plugin/analytics/facebook/facebook_events.dart';
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

    logItemViewEvent(ItemEventModel eventModel)  {
      FBEventManager.instance.viewItemEvent(eventModel);
      FirebaseEvent.instance.logItemViewEvent(eventModel.itemModel);
   }

    logAddToCart(ItemModel itemModel) {
      FirebaseEvent.instance.logAddToCart(itemModel);
      FBEventManager.instance.addToCart(itemModel);
   }

    logRemoveFromCart(ItemModel itemModel) {
      FirebaseEvent.instance.logRemoveFromCart(itemModel);
   }

    logAddToWishlist(ItemEventModel eventModel) {
      FirebaseEvent.instance.logAddToWishlist(eventModel.itemModel);
      FBEventManager.instance.addToWishlist(eventModel);
   }


    logViewCart(CartModel cartModel) {
      FirebaseEvent.instance.logViewCart(cartModel);
   }

    logBeginCheckout(CartModel cartModel) {
      FBEventManager.instance.initiateCheckout(cartModel);
      FirebaseEvent.instance.logBeginCheckout(cartModel);
   }

    logAddShippingInfo(
       CartModel cartModel) {
      FirebaseEvent.instance.logAddShippingInfo(cartModel);
   }

    logPurchase(CartModel cartModel) {
      FBEventManager.instance.purchaseEvents(cartModel);
      FirebaseEvent.instance.logPurchase(cartModel);
   }

    logAddPaymentInfo(CartModel cartModel) {
      FirebaseEvent.instance.logAddPaymentInfo(cartModel);
   }
}