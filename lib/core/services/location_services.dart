import 'package:ais_reporting/features/dashboard/presentation/manager/dashboard_provider.dart';
import 'package:geolocator/geolocator.dart';

import '../utils/globals/globals.dart';

class LocationApi {
  static final DashboardProvider _dashboardProvider = sl();
  static Future<bool> checkAndRequestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    } else {
      return true;
    }
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    late LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _dashboardProvider.turnOffCheckInOutButtonLoading();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _dashboardProvider.turnOffCheckInOutButtonLoading();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _dashboardProvider.turnOffCheckInOutButtonLoading();
      return Future.error(
          'Location permissions are permanently denied, please allow permissions from setting');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    return position;
  }
}
