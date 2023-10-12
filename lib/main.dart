import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_hike/app.dart';
import 'package:m_hike/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  configInjectable();
  runApp(const Application());
}
