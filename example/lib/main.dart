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
      title: 'Magnetic Button',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Offset values = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MagneticButton(
          duration: const Duration(milliseconds: 100),
          onChanged: (Offset value) {
            setState(() => values = value);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                color: Colors.white,
                border: Border.all(color: Colors.black)),
            width: 160,
            height: 80,
            child: Center(
              child: Transform.translate(
                offset: Offset(values.dx / 4, values.dy / 4),
                child: const Text(
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
      ),
    );
  }
}
