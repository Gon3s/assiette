import 'dart:async';
import 'dart:ui';

import 'package:assiette/app.dart';
import 'package:assiette/app_env.dart';
import 'package:assiette/localization/string_hardcoded.dart';
import 'package:assiette/utils/colored_debug_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
Future<void> bootstrap(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();

  EnvInfo.environment = environment;
  EnvInfo.describe();

  _registerErrorHandlers();
  _setupSystemUIOverlayStyle();

  runApp(const ProviderScope(child: MyApp()));
}

void _registerErrorHandlers() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    Print.red('DLOG', details.toString());
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    Print.red('DLOG', error.toString());
    return true;
  };
  ErrorWidget.builder = (details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'.hardcoded),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}

void _setupSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
    ),
  );
}
