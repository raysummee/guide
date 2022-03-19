import 'package:flutter/material.dart';
import 'package:guide/view/screens/map/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Guide',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MapScreen());
  }
}
