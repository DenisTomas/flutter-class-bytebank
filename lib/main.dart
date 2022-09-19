import 'dart:async';

import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'http/webclients/transaction_webclient.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FirebaseCrashlytics.instance.setUserIdentifier('Teste123');
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  runZonedGuarded<Future<void>>(() async {
    runApp(BytebankApp(contactDao: ContactDao(),
    transactionWebClient: TransactionWebClient(),));
  }, FirebaseCrashlytics.instance.recordError);
}

class BytebankApp extends StatelessWidget {

  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  BytebankApp({required this.contactDao, required this.transactionWebClient});

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
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
          home: Dashboard(contactDao: contactDao,),
      ),
    );
  }
}
