import 'package:flutter/cupertino.dart';
import 'package:udemy_demo_1/models/transaction.dart';
import 'package:udemy_demo_1/widgets/transactions/chart.dart';
import 'package:udemy_demo_1/widgets/transactions/list.dart';

class UserTransactions extends StatelessWidget {
  final List<Transaction> transactions;
  // final Function newTxCallback;

  // UserTransactions(this.transactions, this.newTxCallback);
  UserTransactions(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TransactionChart(transactions),
        // TransactionForm(newTxCallback),
        TransactionList(transactions),
      ],
    );
  }
}
