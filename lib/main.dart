import 'package:elkood1/first.dart';
import 'package:flutter/material.dart';
import 'package:elkood1/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  // bool first = true;
  // getPrefs() async{
  //   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // final SharedPreferences prefs = await _prefs;
  // setState(() {
  //   first = prefs.getBool('first') ?? true;
  // });
  // }

  // @override
  // void initState() {
  //   super.initState;
  //   getPrefs();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirsrtScreen(),
      // home: first ? FirsrtScreen() : TaskOne(),
    );
  }
}
