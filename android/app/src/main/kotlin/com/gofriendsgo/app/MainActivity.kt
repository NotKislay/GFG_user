package com.gofriendsgo.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.github.chinloyal.pusher_client.PusherClientPlugin

class MainActivity: FlutterActivity(){
override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(PusherClientPlugin())
    }
}
