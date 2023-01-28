import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './wellcome-login/wellcome_page.dart';
import 'pageone.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'complaint manegement',
      theme: ThemeData(
        scaffoldBackgroundColor: bgcolor,
        textTheme: TextTheme(
          displayMedium: TextStyle(
              color: mainecolor, fontWeight: FontWeight.bold, fontSize: 40),
          //button: TextStyle(color: prcolor),
          displayLarge: TextStyle(
              color: mainecolor, fontWeight: FontWeight.bold, fontSize: 28),
          displaySmall: TextStyle(
              color: mainecolor, fontWeight: FontWeight.bold, fontSize: 12),

          // button: TextStyle(color: Color.fromRGBO(148, 36, 29, 1)),
        ),
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColor,
      ),
      // Arabic RTL
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      home: wellcomsecreen(),
    );
  }
}
