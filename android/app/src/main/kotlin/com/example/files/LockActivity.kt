package com.example.files

import android.app.Activity
import android.os.Bundle
import android.view.View
import android.view.WindowManager
import android.widget.TextView

class LockActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Full screen
        window.setFlags(
            WindowManager.LayoutParams.FLAG_FULLSCREEN,
            WindowManager.LayoutParams.FLAG_FULLSCREEN
        )

        window.decorView.systemUiVisibility =
            View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY or
            View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or
            View.SYSTEM_UI_FLAG_FULLSCREEN

        val textView = TextView(this)
        textView.text = "APP LOCKED"
        textView.textSize = 26f
        textView.setTextColor(android.graphics.Color.WHITE)
        textView.gravity = android.view.Gravity.CENTER

        textView.setBackgroundColor(android.graphics.Color.BLACK)

        setContentView(textView)
    }

    override fun onBackPressed() {
        // Disable back button
    }
}
