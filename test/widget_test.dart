import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expenseapp/main.dart';

void main() {
  testWidgets('Test app initialization', (WidgetTester tester) async {
    await tester.pumpWidget(const ExpenseApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}