import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:pusher_client/pusher_client.dart';

class PusherControlUnit extends ChangeNotifier {
  final apiKey = "c4eaa1411a8253f726ac";
  final cluster = "ap2";
  final authEndPoint = "${APIConstants.baseUrl}/chat/auth";
  var channelName = "private-chatify";
  late PusherClient pusher;
  late Channel channel;

  void initializePusher(
      {required Function(PusherEvent?) onPusherEventReceived}) {
    PusherOptions options = PusherOptions(
      cluster: cluster,
      auth: PusherAuth(authEndPoint, headers: {
        "Authorization": "Bearer ${SharedPreferencesServices.token}",
        "Content-Type": "application/json",
      }),
    );

    try {
      pusher = PusherClient(apiKey, options);
    } catch (e) {
      log("EXCEPTION WHILE INIT PUSHER with option: $options => $e");
    }


    try {
      pusher.connect();
    } catch (e) {
      log("EXCEPTION WHILE CONNECTING PUSHER: $e");
    }

    channel = pusher.subscribe(channelName);

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
