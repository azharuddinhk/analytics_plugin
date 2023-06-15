package com.muscleblaze

import android.content.Context
import android.os.Bundle
import com.facebook.appevents.AppEventsLogger

class FBEventManager(val context: Context) {

    // FACEBOOK - Tagging events
    fun tagFacebookEvent(event: String?, parameters: Bundle?) {
        val logger = AppEventsLogger.newLogger(context)
        logger.logEvent(event, parameters)
    }

    // FACEBOOK - Tagging events
    fun tagFacebookEvent(event: String?, valueToSum: Double?, parameters: Bundle?) {
        val logger = AppEventsLogger.newLogger(context)
        logger.logEvent(event, valueToSum!!, parameters)
    }



}