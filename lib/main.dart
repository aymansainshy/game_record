import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hareeg/app.dart';

import 'package:hareeg/injector.dart' as injector;

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 

  injector.setup();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}
