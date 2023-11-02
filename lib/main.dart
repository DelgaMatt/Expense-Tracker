import 'package:expense_tracker/expenses.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 116, 82, 197));
// global variables set up with 'k' prefix

var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

// .copyWith is allowing you to override specified themes
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // // required to ensure that the locked orientation and running app works as intended
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     // the app will run once the preferred orientation (portrait mode) is set by user
  //     .then((fn) {


  runApp(
    MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDarkColorScheme.primaryContainer,
                foregroundColor: kDarkColorScheme.onPrimaryContainer),
          ),
        ),
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primaryContainer),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 16),
              ),
        ),
        // themeMode: ThemeMode.system // default
        home: const Expenses()),
  );
}
// );}

// primary: This color is often used for the primary elements of your app, like buttons, selected text, and other prominent UI elements.
// onPrimary: This color is often used for text and icons that appear on top of the primary color. It's a color that provides good contrast and readability when placed on the primary color.
// background: This color is typically used for the background of your app's content.
// onBackground: This color is used for text and icons that appear on top of the background color.
