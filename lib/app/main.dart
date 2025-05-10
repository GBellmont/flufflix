import 'package:flufflix/app/core/injection/injections.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flufflix/app/core/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  setupGeneralInjection(prefs: prefs);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flufflix',
      theme: ThemeData(
        textTheme: GoogleFonts.getTextTheme('Inter')
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xff32A873),
            onPrimary: Color(0xff121212),
            secondary: Colors.transparent,
            onSecondary: Color(0xff32A873),
            error: Colors.red,
            onError: Colors.white,
            surface: Color(0xff121212),
            onSurface: Colors.white),
      ),
      routerConfig: AppRoutes.routes,
    );
  }
}
