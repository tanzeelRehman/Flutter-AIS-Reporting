import 'package:flutter/material.dart';
import 'dependency_container.dart' as di;
import 'myApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}
