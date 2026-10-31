package com.example.files

import android.content.Intent
import android.provider.Settings
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val ACCESSIBILITY_CHANNEL = "accesibility"
    private val BLOCK_CHANNEL = "block_selected_app"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // OPEN ACCESSIBILITY SETTINGS
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ACCESSIBILITY_CHANNEL)
            .setMethodCallHandler { call, result ->

                if (call.method == "openAccessibility") {

                    val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    startActivity(intent)

                    result.success(true)

                } else {
                    result.notImplemented()
                }
            }

        // SAVE BLOCKED APPS
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BLOCK_CHANNEL)
            .setMethodCallHandler { call, result ->

                if (call.method == "blockApp") {

                    val apps = call.arguments as List<*>
                    val packageList = apps.filterIsInstance<String>()

                    val prefs = getSharedPreferences("BLOCK_PREFS", Context.MODE_PRIVATE)
                    prefs.edit().putStringSet("blocked_apps", packageList.toSet()).apply()

                    result.success(true)

                } else {
                    result.notImplemented()
                }
            }
    }
}
