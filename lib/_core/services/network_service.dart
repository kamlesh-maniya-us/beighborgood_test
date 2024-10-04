import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../constant/app_constant.dart';

class InternetConnectivityService with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  final StreamController<bool> _connectionChangeController = StreamController.broadcast();

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  InternetConnectivityService.init() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((dataConnectionStatus) async {
      isConnected = dataConnectionStatus.contains(ConnectivityResult.mobile) ||
          dataConnectionStatus.contains(ConnectivityResult.wifi);

      Future.delayed(const Duration(milliseconds: 500), () {
        notifyListeners();
      });

      _connectionChangeController.add(isConnected);
    });
  }

  Stream<bool> get connectivityStatus => _connectionChangeController.stream;
  bool get isConnectivityStatus => isConnected;

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
