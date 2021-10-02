import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './models/transaction.dart';
import './widgets/transactions/chart.dart';
import './widgets/transactions/list.dart';

class UserTransactions extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  final bool showChart;

  UserTransactions(
    this.showChart,
    this.transactions,
    this.deleteTx,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showChart) TransactionChart(transactions),
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: TransactionList(transactions, this.deleteTx),
        ),
      ],
    );
  }
}
