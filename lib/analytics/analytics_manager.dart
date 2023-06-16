import 'package:analytics_plugin/analytics/aws/constant/aws_event_name.dart';
import 'package:analytics_plugin/analytics/branch/analytics_branch_event.dart';
import 'package:analytics_plugin/analytics/facebook/analytics_facebook_events.dart';
import 'package:analytics_plugin/analytics/firebase/analytics_firebase_events.dart';
import 'package:analytics_plugin/analytics/model/event_model.dart';
import 'package:analytics_plugin/analytics/moengage/analytics_moengage_manager.dart';
import 'package:analytics_plugin/analytics/rudderstack/rudder_stack_manager.dart';

import 'aws/constant/model/aws_event_model.dart';

class AnalyticsManager {
  static AnalyticsManager analytics = AnalyticsManager.instance;
  AnalyticsManager._privateConstructor();
  static final AnalyticsManager instance =
      AnalyticsManager._privateConstructor();
  late EcomAnalyticsConfigModel ecomAnalyticsConfigModel;
  factory AnalyticsManager() {
    return instance;
  }

  void initializedAnalytics(EcomAnalyticsConfigModel ecomAnalyticsConfigModel) {
    this.ecomAnalyticsConfigModel = ecomAnalyticsConfigModel;
    if (this.ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance.initializedMoEngage(
          this.ecomAnalyticsConfigModel.moPlugin,
          this.ecomAnalyticsConfigModel.appVersion,
          this.ecomAnalyticsConfigModel.deviceName,
          this.ecomAnalyticsConfigModel.osVersion,
          this.ecomAnalyticsConfigModel.platform);
    }
    if (this.ecomAnalyticsConfigModel.isRudderStack) {
      RudderStackManager.instance.initialisedRudderClient(
          this.ecomAnalyticsConfigModel.writeKey,
          this.ecomAnalyticsConfigModel.dataPlaneUrl);
    }
  }

  void setScreenViewEvents(String screenName) {
    if (ecomAnalyticsConfigModel.isFirebase) {
      AnalyticsFirebaseEvent.instance.recordScreenView(screenName);
    }
  }

  void setAppInstallEvent() {
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance.setAppInstallEvent();
    }
  }

  void setAppUpdateEvent() {
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance.setAppUpdateEvent();
    }
  }

  void setUserAttribute(AnalyticsUserModel userModel) {
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance.setUserAttribute(userModel);
    }
    if (ecomAnalyticsConfigModel.isRudderStack) {
      RudderStackManager.instance.registerUser(userModel);
    }
  }

  void resetUser() {
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance.resetUser();
    }
    if (ecomAnalyticsConfigModel.isRudderStack) {
      RudderStackManager.instance.resetUser();
    }
  }

  logSelectItemViewEvent(AnalyticsItemModel analyticsItemModel) {
    if (ecomAnalyticsConfigModel.isFirebase) {
      AnalyticsFirebaseEvent.instance
          .logSelectItemViewEvent(analyticsItemModel);
    }
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance
          .logSelectItemViewEvent(analyticsItemModel);
    }
    if (ecomAnalyticsConfigModel.isRudderStack) {
      RudderStackManager.instance
          .setProductEvent(AWSEventNames.PRODUCT_CLICKED, analyticsItemModel);
    }
  }

  setProductListViewEvent(List<AnalyticsItemModel> list) {
    if (ecomAnalyticsConfigModel.isFirebase) {
      AnalyticsFirebaseEvent.instance.setProductListViewEvent(list);
    }
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance.setProductListViewEvent(list);
    }
    if (ecomAnalyticsConfigModel.isRudderStack) {
      RudderStackManager.instance.setProductListViewEvent(list);
    }
  }

  logItemViewEvent(AnalyticsItemEventModel eventModel) {
    if (ecomAnalyticsConfigModel.isFacebook) {
      AnalyticsFBEventManager.instance.viewItemEvent(eventModel);
    }
    if (ecomAnalyticsConfigModel.isFirebase) {
      AnalyticsFirebaseEvent.instance
          .logItemViewEvent(eventModel.analyticsItemModel);
    }
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance
          .logItemViewEvent(eventModel.analyticsItemModel);
    }
    if (ecomAnalyticsConfigModel.isRudderStack) {
      RudderStackManager.instance.setProductEvent(
          AWSEventNames.PRODUCT_VIEWED, eventModel.analyticsItemModel);
    }
  }

  logAddToCart(AnalyticsItemModel analyticsItemModel) {
    if (ecomAnalyticsConfigModel.isFirebase) {
      AnalyticsFirebaseEvent.instance.logAddToCart(analyticsItemModel);
    }
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance.logAddToCart(analyticsItemModel);
    }
    if (ecomAnalyticsConfigModel.isBranch) {
      AnalyticsBranchEvent.instance.logAddToCart(analyticsItemModel);
    }
    if (ecomAnalyticsConfigModel.isFacebook) {
      AnalyticsFBEventManager.instance.addToCart(analyticsItemModel);
    }
    if (ecomAnalyticsConfigModel.isRudderStack) {
      RudderStackManager.instance
          .setProductEvent(AWSEventNames.PRODUCT_ADDED, analyticsItemModel);
    }
  }

  logRemoveFromCart(AnalyticsItemModel analyticsItemModel) {
    if (ecomAnalyticsConfigModel.isFirebase) {
      AnalyticsFirebaseEvent.instance.logRemoveFromCart(analyticsItemModel);
    }
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance.logRemoveFromCart(analyticsItemModel);
    }
    if (ecomAnalyticsConfigModel.isRudderStack) {
      RudderStackManager.instance
          .setProductEvent(AWSEventNames.PRODUCT_REMOVED, analyticsItemModel);
    }
  }

  logAddToWishlist(AnalyticsItemEventModel eventModel) {
    if (ecomAnalyticsConfigModel.isFirebase) {
      AnalyticsFirebaseEvent.instance
          .logAddToWishlist(eventModel.analyticsItemModel);
    }
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance
          .logAddToWishlist(eventModel.analyticsItemModel);
    }
    if (ecomAnalyticsConfigModel.isBranch) {
      AnalyticsBranchEvent.instance
          .logAddToWishlistVariant(eventModel.analyticsItemModel);
    }
    if (ecomAnalyticsConfigModel.isFacebook) {
      AnalyticsFBEventManager.instance.addToWishlist(eventModel);
    }
    if (ecomAnalyticsConfigModel.isRudderStack) {
      RudderStackManager.instance.setProductEvent(
          AWSEventNames.PRODUCT_ADDED_TO_WISHLIST,
          eventModel.analyticsItemModel);
    }
  }

  logViewCart(AnalyticsCartModel analyticsCartModel) {
    if (ecomAnalyticsConfigModel.isFirebase) {
      AnalyticsFirebaseEvent.instance.logViewCart(analyticsCartModel);
    }
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance.logViewCart(analyticsCartModel);
    }
    if (ecomAnalyticsConfigModel.isBranch) {
      AnalyticsBranchEvent.instance.logViewCart(analyticsCartModel);
    }
    if (ecomAnalyticsConfigModel.isRudderStack) {
      RudderStackManager.instance.setCartViewEvent(analyticsCartModel);
    }
  }

  logBeginCheckout(AnalyticsCartModel analyticsCartModel) {
    if (ecomAnalyticsConfigModel.isFacebook) {
      AnalyticsFBEventManager.instance.initiateCheckout(analyticsCartModel);
    }
    if (ecomAnalyticsConfigModel.isFirebase) {
      AnalyticsFirebaseEvent.instance.logBeginCheckout(analyticsCartModel);
    }
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance.logBeginCheckout(analyticsCartModel);
    }
    if (ecomAnalyticsConfigModel.isBranch) {
      AnalyticsBranchEvent.instance.logBeginCheckout(analyticsCartModel);
    }
    if (ecomAnalyticsConfigModel.isRudderStack) {
      RudderStackManager.instance.checkoutStartedEvent(analyticsCartModel);
    }
  }

  logAddShippingInfo(AnalyticsCartModel analyticsCartModel) {
    if (ecomAnalyticsConfigModel.isFirebase) {
      AnalyticsFirebaseEvent.instance.logAddShippingInfo(analyticsCartModel);
    }
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance.logAddShippingInfo(analyticsCartModel);
    }
  }

  logPurchase(AnalyticsCartModel analyticsCartModel) {
    if (ecomAnalyticsConfigModel.isFacebook) {
      AnalyticsFBEventManager.instance.purchaseEvents(analyticsCartModel);
    }
    if (ecomAnalyticsConfigModel.isFirebase) {
      AnalyticsFirebaseEvent.instance.logPurchase(analyticsCartModel);
    }
    if (ecomAnalyticsConfigModel.isMoengage) {
      AnalyticsMoEngageManager.instance.logPurchase(analyticsCartModel);
    }
    if (ecomAnalyticsConfigModel.isBranch) {
      AnalyticsBranchEvent.instance.logPurchase(analyticsCartModel);
    }
    if (ecomAnalyticsConfigModel.isRudderStack) {
      RudderStackManager.instance.submitPurchaseEvent(analyticsCartModel);
    }
  }

  logAddPaymentInfo(AnalyticsCartModel analyticsCartModel) {
    if (ecomAnalyticsConfigModel.isFirebase) {
      AnalyticsFirebaseEvent.instance.logAddPaymentInfo(analyticsCartModel);
    }
  }

  setSingleAttributeEvent(
      {required String eventName, required String key, required String value}) {
    RudderStackManager.instance
        .setSingleAttributeEvent(eventName: eventName, key: key, value: value);
  }

  setEventWithAttributes(String eventName, Map<String, dynamic> attributes) {
    RudderStackManager.instance.setEventWithAttributes(eventName, attributes);
  }

  setOrderCancelEvent(AnalyticsCartModel cartModel) {
    RudderStackManager.instance.orderCancelEvent(cartModel);
  }

  submitProductReview(int productId, String reviewDescription, int rating) {
    RudderStackManager.instance
        .submitProductReview(productId, reviewDescription, rating);
  }
}
