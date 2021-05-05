import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpnow_assignment/constants.dart';
import 'package:helpnow_assignment/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HelpNow',
      theme: ThemeData(
        fontFamily: 'Grold',
        primaryColor: kPrimaryColor,
      ),
      home: HomeScreen(),
    );
  }
}
