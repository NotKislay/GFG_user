import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherControlUnit extends ChangeNotifier {
  // final apiKey = "c4eaa1411a8253f726ac";
  final apiKey = "52708fc78597deb505e2";
  final cluster = "ap2";
  bool isSubscribed = false;
  final authEndPoint = "${APIConstants.baseUrl}/chat/auth";
  // var channelName = "";
  var channelName = "private-chatify";
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  // late PusherClient pusher;
  // late Channel channel;

  void initializePusher(
      {required Function(PusherEvent?) onPusherEventReceived}) async {
    try {
      isSubscribed = false;
      //log("=== PUSHER: INITIALIZING CLIENT ===");
      await pusher.init(
        apiKey: apiKey,
        cluster: cluster,
        onAuthorizer:
            (String channelName, String socketId, dynamic options) async {
          //log("MANUALLY AUTHORIZING CHANNEL: $channelName WITH SOCKET ID: $socketId");

          // Fire a direct manual HTTP request to your backend
          try {
            var response = await http.post(
              Uri.parse("${APIConstants.baseUrl}/chat/auth"),
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "Bearer ${SharedPreferencesServices.token}",
              },
              body: {
                "socket_id": socketId,
                "channel_name": channelName,
              },
            );

            //log("MANUAL AUTH RESPONSE BODY: ${response.body}");

            // Decode the backend signature and pass it back to Pusher
            final jsonResponse = jsonDecode(response.body);
            return jsonResponse;
          } catch (e) {
            //log("MANUAL AUTHENTICATION CRASH: $e");
            return null;
          }
        },
        // Global connection monitors
        onConnectionStateChange: (currentState, previousState) {
          //log("PUSHER STATE CHANGED: From $previousState to $currentState");
        },
        onError: (String message, int? code, dynamic error) {
          //log("PUSHER ERROR: $message (Code: $code) -> Exception: $error");
        },
        onSubscriptionSucceeded: (String channel, dynamic data) {
          isSubscribed = true;
          //log("PUSHER SUBSCRIPTION SUCCESSFUL: Subscribed to $channel");
        },
        onSubscriptionError: (String message, dynamic error) {
          //log("PUSHER SUBSCRIPTION ERROR: $message -> $error");
        },
        onEvent: (event) {
          //log("GLOBAL EVENT RECORDED: ${event.eventName} on channel ${event.channelName}");

          // 2. Filter the incoming events so they only trigger for your active chat screen
          if (event.channelName == channelName) {
            if (event.eventName == TextStrings.eventClientMes ||
                event.eventName == TextStrings.eventClientTyp ||
                event.eventName == TextStrings.eventClientSeen) {
              onPusherEventReceived(event);
            }
          }
        },
      );

      // Connect to the WebSocket stream
      await pusher.connect();
      //log("PUSHER: CONNECT METHOD CALLED SUCCESSFULLY");

      // Subscribe to your channel and handle bound events inside a single callback
      await pusher.subscribe(
        channelName: channelName,
      );
    } catch (e) {
      //log("CRITICAL ERROR IN PUSHER INITIALIZATION LIFECYCLE: $e");
    }
  }

  void triggerEvent(
      {required String targetChannelName,
      required String eventName,
      required Map<String, dynamic> data}) {
    try {
      //log("=== PUSHER: TRIGGERING CLIENT EVENT: $eventName ===");

      if (!isSubscribed) {
        //log("BLOCKED TRIGGER: Channel is not fully subscribed yet.");
        return;
      }
      pusher.trigger(
        PusherEvent(
          channelName:
              targetChannelName, // Uses the class level variable "private-chatify"
          eventName: eventName, // E.g., TextStrings.eventClientTyp
          data: jsonEncode(
              data), // The new SDK requires the payload to be a JSON string
        ),
      );
    } catch (e) {
      log("ERROR TRIGGERING CLIENT EVENT: $e");
    }
  }

  Future<void> disconnectPusher() async {
    await pusher.unsubscribe(channelName: channelName);
    await pusher.disconnect();
    log("PUSHER: DISCONNECTED AND UNSUBSCRIBED");
  }
}
