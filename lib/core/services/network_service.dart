import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils/enums/network_status.dart';

//TODO Have to remove network service if not needed
class NetworkStatusService {
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  NetworkStatusService() {
    Connectivity().onConnectivityChanged.listen((status) {
      print("changing");
      networkStatusController.add(_getNetworkStatus(status));
    });
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi
        ? NetworkStatus.Online
        : NetworkStatus.Offline;
  }
}
