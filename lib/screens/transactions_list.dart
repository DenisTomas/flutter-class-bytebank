import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

import '../components/progress.dart';

class TransactionsList extends StatelessWidget {
   TransactionsList({Key? key}) : super(key: key);

  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transactions'),
        ),
        body: FutureBuilder<List<Transaction>>(
          future: _webClient.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;

              case ConnectionState.waiting:
                return Progress();

              case ConnectionState.active:
                break;

              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transaction>? transactions = snapshot.data;
                  if (transactions!.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transaction transaction = transactions[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.monetization_on),
                            title: Text(
                              transaction.value.toString(),
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transaction.contact.accountNumber.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: transactions.length,
                    );
                  }
                }
                return const CenteredMessage(
                  'No Transaction Found',
                  icon: Icons.warning_amber_rounded,
                );
            }

            return const CenteredMessage(
              'Unknown error',
              icon: Icons.warning_amber_rounded,
            );
          },
        ));
  }
}
