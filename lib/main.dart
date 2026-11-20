// DW:BEGIN firebase_imports
import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// DW:END firebase_imports
import 'package:flutter/services.dart';
import 'dartweave_navigation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // DW:BEGIN firebase
  WidgetsFlutterBinding.ensureInitialized();
  // DW:BEGIN preRunApp
  unawaited(MobileAds.instance.initialize());
  // DW:END preRunApp
  // DW:END firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Full Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF4FD8C4),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
home: const _DartWeaveStartPage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supabase Full Lab'),
      ),
      body: const Center(
        child: Text(
          'Hello from Supabase Full Lab!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
class _DartWeaveStartPage extends StatefulWidget {
  const _DartWeaveStartPage();
  @override State<_DartWeaveStartPage> createState() => _DartWeaveStartPageState();
}
class _DartWeaveStartPageState extends State<_DartWeaveStartPage> {
  @override void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: const Color(0x0F172AFF),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations(const <DeviceOrientation>[]);
  }
  @override void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    SystemChrome.setPreferredOrientations(const <DeviceOrientation>[]);
    super.dispose();
  }
  @override Widget build(BuildContext context) => NavigationService.page("Auth");
}
