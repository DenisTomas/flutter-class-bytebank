import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final contact = Contact(null, 'Nome_Teste', 0000);

  test('Should return value when create a transaction', () {
    final transaction = Transaction('', 200, contact);
    expect(transaction.value, 200);
    expect(transaction.contact.accountNumber, 0000);
  });

  test(
      'Should show error when a transaction with value less then zero is created',
      () {
    expect(() => Transaction('', -1, contact), throwsAssertionError);
  });

  test('Should show error when a transaction with value equals zero is created',
      () {
    expect(() => Transaction('', 0, contact), throwsAssertionError);
  });

  test('Should show error when a transaction with null value is created', () {
    expect(() => Transaction('', null, contact), throwsAssertionError);
  });
}
