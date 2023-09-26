import 'package:flutter/material.dart';

import 'package:magnetic_button/magnetic_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final innerMagneticButtonKeys = GlobalKey<MagneticButtonState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MagneticButton(
          key: innerMagneticButtonKeys,
          duration: const Duration(milliseconds: 100),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                color: Colors.white,
                border: Border.all(color: Colors.black)),
            width: 160,
            height: 80,
            child: const Center(
              child: Text(
                'Explore',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 19,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
