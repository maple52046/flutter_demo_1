import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy_demo_1/models/transaction.dart';
import 'package:udemy_demo_1/widgets/typographies/titles.dart';

import 'card.dart';

class NoTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Expanded(child: Image.asset('assets/images/j5NU6WZN1nA.png')),
        ),
        Text(
          'No Transaction In List.',
          style: GoogleFonts.arapey(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Title22('Transaction List'),
        Expanded(
          child: transactions.isEmpty
              ? NoTransaction()
              : ListView.builder(
                  itemBuilder: (_, index) =>
                      TransactionCard(transactions[index], deleteTx),
                  itemCount: transactions.length,
                ),
        ),
      ],
    );
  }
}
