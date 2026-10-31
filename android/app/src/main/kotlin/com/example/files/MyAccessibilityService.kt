package com.example.files

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent
import android.content.Context
import android.content.Intent
import android.util.Log

class MyAccessibilityService : AccessibilityService() {

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {

        if (event == null) return

        if (event.eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {

            val packageName = event.packageName?.toString() ?: return

            Log.d("LOCK_DEBUG", "Current package: $packageName")

            if (packageName == applicationContext.packageName) return

            val blockedApps = getBlockedApps()

            Log.d("LOCK_DEBUG", "Blocked apps: $blockedApps")

            if (blockedApps.contains(packageName)) {

                Log.d("LOCK_DEBUG", "APP TERBLOKIR!")

                val intent = Intent(this, LockActivity::class.java)
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                startActivity(intent)
            }
        }
    }

    override fun onInterrupt() {}

    private fun getBlockedApps(): Set<String> {
        val prefs = getSharedPreferences("BLOCK_PREFS", Context.MODE_PRIVATE)
        return prefs.getStringSet("blocked_apps", emptySet()) ?: emptySet()
    }
}
