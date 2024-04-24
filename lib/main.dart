import 'package:flutter/material.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_strings.dart';
import 'package:flutter_weather_app_clone/Presentation/Screens/home_page_screen.dart';

/*
Title: Entry Point of a App
Purpose:Entry Point of a App
Created On: 23/04/2024
Edited On:23/04/2024
Author: Kalpesh Khandla
*/
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePageScreen(),
    );
  }
}
