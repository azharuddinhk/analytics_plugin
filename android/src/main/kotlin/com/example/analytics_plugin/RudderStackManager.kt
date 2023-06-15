package com.example.analytics_plugin

import android.content.Context
import com.rudderstack.android.integration.branch.BranchIntegrationFactory
import com.rudderstack.android.integration.firebase.FirebaseIntegrationFactory
import com.rudderstack.android.sdk.core.RudderClient
import com.rudderstack.android.sdk.core.RudderConfig
import com.rudderstack.android.sdk.core.RudderProperty
import com.rudderstack.android.sdk.core.RudderTraits
import java.util.*


class RudderStackManager(val context: Context) {
    private lateinit var rudderClient: RudderClient
    fun initialisedRudder(writeKey : String, dataPlaneUrl : String){
         rudderClient = RudderClient.getInstance(
                context,
                writeKey,
                RudderConfig.Builder()
                        .withDataPlaneUrl(dataPlaneUrl)
                        .withFactory(FirebaseIntegrationFactory.FACTORY)
                        .withFactory(BranchIntegrationFactory.FACTORY)
                        .withTrackLifecycleEvents(true)
                        .withRecordScreenViews(true)
                        .build()
        )

    }
    fun recordEvents(eventName: String, params: Map<String, Any>){
        var rudderProperty = RudderProperty()
        for (entry in params)
            rudderProperty.put(entry.key, entry.value)
        rudderClient.track(
                eventName,
                rudderProperty
        )
    }
    fun recordScreenEvents(screenName: String){
        rudderClient.screen(
                screenName)
    }
    fun registerUser( params: Map<String, Any>){
        val traits = RudderTraits()
        traits.putBirthday(Date())
        traits.putEmail(params["email"]?.toString() ?: "")
        traits.putName(params["name"]?.toString() ?: "")
        traits.putPhone( "91" +(params["mobile"]?.toString() ?: ""))
        traits.putId(params["userId"]?.toString() ?: "")
        traits.put("date", params["date"] ?:Date(System.currentTimeMillis()))
        rudderClient.identify(params["userId"]?.toString() ?: "user", traits, null)

    }
    fun resetUser(){
        rudderClient.reset()

    }
}