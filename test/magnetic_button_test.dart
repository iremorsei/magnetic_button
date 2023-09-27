import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magnetic_button/magnetic_button.dart';

void main() {
  testWidgets('Check MagneticWidget exists', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: MagneticButton(
              onChanged: (Offset value) {},
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF303032))),
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
        ),
      ),
    );

    final magneticFinder = find.byType(MagneticButton);
    expect(magneticFinder, findsOneWidget);
  });
}
