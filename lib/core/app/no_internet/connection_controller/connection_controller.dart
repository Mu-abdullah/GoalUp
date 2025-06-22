import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectionController {
  ConnectionController._();

  ValueNotifier<bool> isConnected = ValueNotifier(true);

  static final ConnectionController instance = ConnectionController._();

  Future<void> init() async {
    await checkConnection();
    final result = await Connectivity().checkConnectivity();
    isInternetConnected(result);
    Connectivity().onConnectivityChanged.listen(isInternetConnected);
  }

  bool isInternetConnected(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none) && results.length == 1) {
      isConnected.value = false;
      return false;
    } else if (results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi)) {
      isConnected.value = true;
      return true;
    }
    isConnected.value = false;
    return false;
  }

  Future<void> checkConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        isConnected.value = false;
        return;
      }
      final result = await InternetAddress.lookup('google.com').timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw Exception('Timeout'),
      );
      isConnected.value = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      isConnected.value = false;
    }
  }
}
