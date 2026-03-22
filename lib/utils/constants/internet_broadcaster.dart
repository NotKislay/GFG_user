import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

import '../color_theme/colors.dart';

class InternetBroadcaster extends StatefulWidget {
  final Widget child;

  const InternetBroadcaster({super.key, required this.child});

  @override
  State<InternetBroadcaster> createState() => _InternetBroadcasterState();
}

class _InternetBroadcasterState extends State<InternetBroadcaster> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _isConnected = true;

  @override
  void initState() {
    _checkInitialConnection();
    _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      final hasConnection = results.any((result) => result != ConnectivityResult.none);
      _updateConnectionStatus(hasConnection);
    });

    super.initState();
  }

  void _checkInitialConnection() async {
    final result = await Connectivity().checkConnectivity();
    final hasConnection =
        result.any((result) => result != ConnectivityResult.none);
    _updateConnectionStatus(hasConnection);
  }

  void _updateConnectionStatus(bool hasInternet) {
    setState(() {
      _isConnected = hasInternet;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          if(!_isConnected)
            Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: AppColors.gradientColors,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppImages.offlineIcon, color: Colors.white,
                            width: 200,
                            height: 200),
                        const Text("You are Offline",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                )
            )

        ],
      ),
    );
  }
}
