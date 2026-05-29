import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:pusher_client/pusher_client.dart';

class PusherControlUnit extends ChangeNotifier {
  // final apiKey = "c4eaa1411a8253f726ac";
  final apiKey = "52708fc78597deb505e2";
  final cluster = "ap2";
  final authEndPoint = "${APIConstants.baseUrl}/chat/auth";
  // var channelName = "private-chatify";
  var channelName = "chatify-test-public";
  late PusherClient pusher;
  late Channel channel;

  void initializePusher(
      {required Function(PusherEvent?) onPusherEventReceived}) {
        print("=== PUSHER DEBUG: STARTING INITIALIZATION ===");
  print("=== PUSHER DEBUG: USING KEY: ${apiKey.substring(15)} ===");
    PusherOptions options = PusherOptions(
      cluster: cluster,
      auth: PusherAuth(authEndPoint, headers: {
        "Authorization": "Bearer ${SharedPreferencesServices.token}",
        "Content-Type": "application/json",
      }),
    );

    try {
      print("=== PUSHER DEBUG: TRYING TO CREATE CLIENT ===");
      pusher = PusherClient(apiKey, options);
print("=== PUSHER DEBUG: CLIENT CREATED SUCCESSFULLY ===");
      pusher.onConnectionStateChange((state) {
        print("PUSHER STATE: ${state?.currentState}");
      });

      pusher.onConnectionError((error) {
        print("PUSHER ERROR: ${error?.message} | Code: ${error?.code}");
      });
      print("=== PUSHER DEBUG: LISTENERS ATTACHED ===");
    } catch (e) {
      log("EXCEPTION WHILE INIT PUSHER with option: $options => $e");
    }

    try {
      print("=== PUSHER DEBUG: TRYING TO CONNECT ===");
    pusher.connect();
    print("=== PUSHER DEBUG: CONNECT METHOD CALLED ===");
    } catch (e) {
      log("EXCEPTION WHILE CONNECTING PUSHER: $e");
    }

    channel = pusher.subscribe(channelName);
    print("=== PUSHER DEBUG: TRYING TO SUBSCRIBE TO $channelName ===");
    channel.bind(TextStrings.eventClientMes, (PusherEvent? event) {
      if (event != null) {
        onPusherEventReceived(event);
      }
    });
    channel.bind(TextStrings.eventClientTyp, (PusherEvent? event) {
      if (event != null) {
        log("TYPING: $event");
        onPusherEventReceived(event);
      }
    });
    channel.bind(TextStrings.eventClientSeen, (PusherEvent? event) {
      if (event != null) {
        onPusherEventReceived(event);
      }
    });
  }

  void triggerEvent(String eventName, Map<String, dynamic> data) {
    channel.trigger(eventName, data);
  }
}
