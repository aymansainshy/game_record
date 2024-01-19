import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hareeg/app.dart';

import 'package:hareeg/injector.dart' as injector;
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  injector.setup();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}
