import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/widgets/icon_field.dart';

void main() {
  testWidgets('IconField has iconData and text in a row by default',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: IconField(iconData: Icons.today, text: 'test'),
      ),
    );

    final iconFinder = find.widgetWithIcon(Row, Icons.today);

    expect(iconFinder, findsOneWidget);
  });

  testWidgets('IconField can display iconData and text in a column',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: IconField(iconData: Icons.today, text: 'test', vertical: true),
      ),
    );

    final iconFinder = find.widgetWithIcon(Column, Icons.today);

    expect(iconFinder, findsOneWidget);
  });
}
