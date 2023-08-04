import 'package:app_davivienda/widgets/gastos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 107, 75, 160));

var kDartColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // // la linea 14 se una para establecer que la app solo funcione en vertical
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((fn) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith( 
          useMaterial3: true,
          colorScheme: kDartColorScheme,
          cardTheme: const CardTheme().copyWith(
              color: kDartColorScheme.secondaryContainer,
              margin: const EdgeInsets.fromLTRB(16, 10, 16, 10)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDartColorScheme.primaryContainer,
                foregroundColor: kDartColorScheme.onPrimaryContainer),
          ),
        ),
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer,
              titleTextStyle: const TextStyle(fontSize: 22)),
          cardTheme: CardTheme().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: const EdgeInsets.fromLTRB(16, 10, 16, 10)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 16)),
        ),
        home: const Gastos(),
      ),
    );
  }
  //);
//}
