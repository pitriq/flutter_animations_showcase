import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_animations_showcase/common/colors.dart';
import 'package:flutter_animations_showcase/example_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _getTheme(),
      home: const ExamplePickerView(),
    ),
  );
}

ThemeData _getTheme() {
  final nunito = GoogleFonts.nunitoTextTheme();
  final textTheme = nunito.copyWith(
    displaySmall: nunito.displaySmall!.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: textPrimary,
    ),
    titleLarge: nunito.titleLarge!.copyWith(
      color: primary,
      fontWeight: FontWeight.w700,
    ),
  );
  return ThemeData(
    textTheme: textTheme,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: _getButtonTheme(textTheme),
    appBarTheme: _getAppBarTheme(textTheme),
  );
}

ElevatedButtonThemeData _getButtonTheme(TextTheme textTheme) {
  final buttonTextStyle = textTheme.labelLarge!.copyWith(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: .2,
  );
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: 0.0.asMaterialProp(),
      backgroundColor: primary.asMaterialProp(),
      overlayColor: Colors.white.withOpacity(.05).asMaterialProp(),
      textStyle: buttonTextStyle.asMaterialProp(),
      fixedSize: const Size.fromHeight(52).asMaterialProp(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ).asMaterialProp(),
    ),
  );
}

AppBarTheme _getAppBarTheme(TextTheme textTheme) {
  return AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: textPrimary,
    titleTextStyle: textTheme.bodyLarge!.copyWith(fontSize: 17),
  );
}

extension MaterialStatePropertyExtension<T> on T {
  MaterialStateProperty<T> asMaterialProp() {
    return MaterialStateProperty.all(this);
  }
}
