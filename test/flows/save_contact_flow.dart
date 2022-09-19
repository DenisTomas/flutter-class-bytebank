import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'matchers.dart';
import 'mocks.dart';

void main() {
  testWidgets('Should save a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(contactDao: mockContactDao,));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfers', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);

    await tester.tap(transferFeatureItem);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
    for (int i = 0; i < 5; i++) {
      await tester.pump(Duration(seconds: 1));
    }

    final contactForm = find.byType(ContactList);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate((widget) {
      return _textFieldMatcher(widget, 'Full Name');
    });
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'Denis');

    final accountNumberTextField = find.byWidgetPredicate((widget) {
      return _textFieldMatcher(widget, 'Account Number');
    });
    expect(accountNumberTextField, findsOneWidget);
    await tester.enterText(nameTextField, '1111');

    final createButton = find.widgetWithText(ElevatedButton, 'Create');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(mockContactDao.save(Contact(0, 'Denis', 1111)));

    final contactListBack = find.byType(ContactList);
    expect(contactListBack, findsOneWidget);

    verify(mockContactDao.findAll());

  });
}

bool _textFieldMatcher(Widget widget, String labelText) {
   if (widget is TextField) {
    return widget.decoration?.labelText == labelText;
  }
  return false;
}
