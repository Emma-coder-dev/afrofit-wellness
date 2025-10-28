// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:afrofit_wellness/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AfroFitWellnessApp());

    // Verify that app starts with Welcome screen
    expect(find.text('Welcome to AfroFit Wellness'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}