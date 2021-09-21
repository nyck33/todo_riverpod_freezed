// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:master_plan/main.dart';

void main() {
  testWidgets('see if I land on FirstScreen with dummyUser',
      (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
        child: MaterialApp(
            home: MasterPlanApp(
      plans: [],
    ))));
    //finders
    final titleFinder = find.text('Master Plans');
    expect(titleFinder, findsOneWidget);
  });
}
