import 'package:ais_reporting/core/utils/enums/network_status.dart';
import 'package:ais_reporting/core/utils/globals/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget onlineChild;
  final Widget offlineChild;

  const NetworkAwareWidget(
      {Key? key, required this.onlineChild, required this.offlineChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NetworkStatus networkStatus = Provider.of<NetworkStatus>(context);
    if (networkStatus == NetworkStatus.Online) {
      return onlineChild;
    } else {
      ShowSnackBar.show("Disconnected");
      return offlineChild;
    }
  }
}
