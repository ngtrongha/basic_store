package com.hncrop.vnstore

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    // Keep FlutterActivity's default configuration.
    super.configureFlutterEngine(flutterEngine)

    // Ensure generated plugins are registered (fixes "channel-error" for plugins such as
    // path_provider when automatic registration doesn't run for a given build setup).
    try {
      GeneratedPluginRegistrant.registerWith(flutterEngine)
    } catch (_: IllegalStateException) {
      // Plugins were already registered on this engine (safe to ignore).
    }
  }
}
