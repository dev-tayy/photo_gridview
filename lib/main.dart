import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:photo_view/app.manager.dart';
import 'package:photo_view/bloc/photo.bloc.dart';
import 'package:photo_view/data/photo.repository.dart';
import 'package:photo_view/screens/home.view.dart';
import 'package:photo_view/utils/utils.dart';

void main() async {
  await AppManager.initializeDependencies();
  await getIt.allReady();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      toastTheme: ToastThemeData(alignment: Alignment.bottomCenter),
      child: BlocProvider<PhotoBloc>(
        create: (context) => PhotoBloc(getIt.get<PhotoRepository>()),
        child: MaterialApp(
          title: 'Photo Gallery',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}
