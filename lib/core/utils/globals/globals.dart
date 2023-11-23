import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GlobalKey<NavigatorState> navigatorKeyGlobal = GlobalKey<NavigatorState>();
final sl = GetIt.instance;

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
