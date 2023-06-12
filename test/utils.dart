import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_view/app.manager.dart';
import 'package:photo_view/bloc/photo.bloc.dart';
import 'package:photo_view/data/photo.repository.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpRealRouterApp(
      Widget widget, PhotoRepository photoRepository) {
    return pumpWidget(BlocProvider<PhotoBloc>(
      create: (context) => PhotoBloc(photoRepository),
      child: HookBuilder(
        builder: (context) {
          return MaterialApp(
            builder: (context, child) {
              return widget;
            },
          );
        },
      ),
    ));
  }
}

Future<void> loadPathProvider() async {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (MethodCall methodCall) async {
    return 'tmp/${DateTime.now()}';
  });
}

Future<void> initializeDeps() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  Hive.init('tmp/${DateTime.now()}');
  await AppManager.initializeDependencies();
  await getIt.allReady();
}
