import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BytebankApp());
  //findAll().then((transactions) => print('NEW TRANSACTIONS $transactions'));
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green[900],
          appBarTheme: AppBarTheme(color: Colors.green[900]),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.green[900],
            secondary: Colors.green[700],
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green.shade700),
            ),
          ),
        ),
        home: const Dashboard());
  }
}
