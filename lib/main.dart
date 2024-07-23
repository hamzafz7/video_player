import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:video_player/presentation/home/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MediaKit.ensureInitialized();
  DartVLC.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AudioPlayerScreen());
  }
}
