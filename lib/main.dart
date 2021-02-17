import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:autofact/corp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('fr')
      ],
      title: 'FactAuto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
          fontFamily: 'Century Gothic'
      ),
      home: Corp(),
    );
  }
}