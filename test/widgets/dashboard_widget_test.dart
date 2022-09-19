import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

void main() {
  testWidgets('Should display main image when Dashboard is opened',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(home: Dashboard(contactDao: ContactDao())));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets('Should display the Transfer feature when Dashboard is opened',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(home: Dashboard(contactDao: ContactDao())));
    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
  });

  testWidgets('Should display the Transaction feature when Dashboard is opened',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(home: Dashboard(contactDao: ContactDao(),)));
    final transactionListFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transaction List', Icons.description));
    expect(transactionListFeatureItem, findsOneWidget);
  });
}


