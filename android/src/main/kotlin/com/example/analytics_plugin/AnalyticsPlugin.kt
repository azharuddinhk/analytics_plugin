package com.example.analytics_plugin

import android.app.Activity
import android.content.Context
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.annotation.NonNull
import com.amazonaws.mobile.client.AWSMobileClient
import com.amazonaws.mobile.client.Callback
import com.amazonaws.mobile.client.UserStateDetails
import com.amazonaws.mobile.config.AWSConfiguration
import com.amazonaws.mobileconnectors.pinpoint.PinpointConfiguration
import com.amazonaws.mobileconnectors.pinpoint.PinpointManager
import com.amazonaws.mobileconnectors.pinpoint.analytics.AnalyticsEvent
import com.muscleblaze.FBEventManager
import io.flutter.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.ref.WeakReference

/** AnalyticsPlugin */
class AnalyticsPlugin: FlutterPlugin, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private var activity: Activity? = null
  private var binaryMessenger: BinaryMessenger? = null
  private var channel: MethodChannel? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    binaryMessenger = binding.binaryMessenger
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    // TODO: your plugin is now attached to an Activity
    this.activity =  binding.activity

    channel = MethodChannel(binaryMessenger!!, "analytics_plugin")
    val methodChannelHandler =
            MethodChannelHandler(
                    WeakReference(activity), WeakReference(channel),
                    applicationContext = activity!!.applicationContext
            )
    channel?.setMethodCallHandler(methodChannelHandler)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    // TODO: the Activity your plugin was attached to was destroyed to change configuration.
    // This call will be followed by onReattachedToActivityForConfigChanges().
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    // TODO: your plugin is now attached to a new Activity after a configuration change.
  }

  override fun onDetachedFromActivity() {
    // TODO: your plugin is no longer associated with an Activity. Clean up references.
  }


  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    Log.d("DART/NATIVE", "onDetachedFromEngine")
    channel?.setMethodCallHandler(null)
  }
  class MethodChannelHandler(
          private val activity: WeakReference<Activity>,
          private val methodChannel: WeakReference<MethodChannel>,
          private val applicationContext: Context,
          private var pinpointManager: PinpointManager? = null,
          private var fbEventManager: FBEventManager = FBEventManager(applicationContext),
          private var rudderStack: RudderStackManager = RudderStackManager(applicationContext)
  ) : MethodChannel.MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
      when (call.method) {
        "recordAWSEvent" -> {
          if (call.arguments != null) {
            val paramsMap = call.arguments<Map<String, Any>>()
            paramsMap?.let {
              sendAWSEvent(
                      paramsMap["eventName"] as String,
                      paramsMap["eventAttribute"] as Map<String, String>
              )
            }
          }
        }
        "recordFacebookEvents" -> {
          if (call.arguments != null) {
            val paramsMap = call.arguments<Map<String, Any>>()
            paramsMap?.let {
              val eventName = paramsMap["eventName"] as String
              val eventAttribute = paramsMap["eventAttribute"] as Map<String, Any>
              val price = paramsMap["price"] as Double?
              val bundle = Bundle()
              for (entry in eventAttribute)
                bundle.putString(entry.key, entry.value.toString())
              if (price == null)
                fbEventManager.tagFacebookEvent(eventName, bundle)
              else
                fbEventManager.tagFacebookEvent(eventName, price, bundle)
            }
          }
        }
        "initialisedRudderClient" -> {
          if (call.arguments != null) {
            val paramsMap = call.arguments<Map<String, Any>>()
            paramsMap?.let {
              rudderStack.initialisedRudder(paramsMap["writeKey"] as String, paramsMap["dataUrl"] as String)
            }
          }
        }
        "recordRudderStackEvents" -> {
          if (call.arguments != null) {
            val paramsMap = call.arguments<Map<String, Any>>()
            paramsMap?.let {
              rudderStack.recordEvents( paramsMap["eventName"] as String, paramsMap["eventAttribute"] as Map<String, String>)

            }
          }
        }
        "recordRudderStackScreenEvent" -> {
          if (call.arguments != null) {
            val paramsMap = call.arguments<Map<String, Any>>()
            paramsMap?.let {
              rudderStack.recordScreenEvents( paramsMap["screenName"] as String)

            }
          }
        }
        "recordRudderStackUserEvent" -> {
          if (call.arguments != null) {
            val paramsMap = call.arguments<Map<String, Any>>()
            paramsMap?.let {
             rudderStack.registerUser(paramsMap)

            }
          }
        }
        "resetRudderStackUser" -> {
          rudderStack.resetUser()
        }


      }

    }
    private fun sendAWSEvent(event: String, paramsMap: Map<String, String>) {
      try {
        getPinpointManager(applicationContext = applicationContext)
        pinpointManager?.sessionClient?.startSession()
        val analyticsEvent: AnalyticsEvent? =
                pinpointManager?.analyticsClient?.createEvent(event)
        paramsMap.map {
          analyticsEvent?.withAttribute(it.key, it.value)
        }
        pinpointManager?.analyticsClient?.recordEvent(analyticsEvent)
        pinpointManager?.sessionClient?.stopSession()
        pinpointManager?.analyticsClient?.submitEvents()
      } catch (e: Exception) {
        e.printStackTrace()
      }
    }
    fun getPinpointManager(applicationContext: Context?): PinpointManager {
      if (pinpointManager == null) {
        // Initialize the AWS Mobile Client
        val awsConfig = AWSConfiguration(applicationContext)
        AWSMobileClient.getInstance()
                .initialize(applicationContext, awsConfig, object : Callback<UserStateDetails> {
                  override fun onResult(userStateDetails: UserStateDetails?) {}
                  override fun onError(e: java.lang.Exception?) {}
                })
        val pinpointConfig = PinpointConfiguration(
                applicationContext,
                AWSMobileClient.getInstance(),
                awsConfig
        )
        pinpointManager =
                PinpointManager(pinpointConfig)
      }
      return pinpointManager as PinpointManager
    }
  }
}
