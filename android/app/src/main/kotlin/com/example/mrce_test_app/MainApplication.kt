package com.example.mrce_test_app

import android.app.Application
import android.util.Log
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setLocale("ru_RU")

        val apiKey =
            packageManager
                .getApplicationInfo(packageName, 128)
                .metaData
                ?.getString("YANDEX_MAPKIT_API_KEY")
                ?.trim()

        if (!apiKey.isNullOrEmpty()) {
            MapKitFactory.setApiKey(apiKey)
        } else {
            Log.w("MainApplication", "YANDEX_MAPKIT_API_KEY is missing")
        }
    }
}
