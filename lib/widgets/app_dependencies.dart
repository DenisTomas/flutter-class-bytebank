import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:flutter/material.dart';

import '../http/webclients/transaction_webclient.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  AppDependencies({
    required Widget child,
    required this.contactDao,
    required this.transactionWebClient,
  }) : super(child: child);

  static AppDependencies of(BuildContext context) {
    final AppDependencies? result = context.dependOnInheritedWidgetOfExactType<
        AppDependencies>();
    assert (result != null, 'No App dependencies found');
    return result!;
  }

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contactDao != oldWidget.contactDao ||
        transactionWebClient != oldWidget;
  }
}
