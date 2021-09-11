import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy_demo_1/models/transaction.dart';
import 'package:udemy_demo_1/widgets/text_title.dart';

import 'card.dart';

class NoTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 200,
          child: Image.asset('assets/images/j5NU6WZN1nA.png'),
        ),
        title: Text(
          'No Transaction In List.',
          style: GoogleFonts.arapey(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Title22('Transaction List'),
        Container(
          height: 400,
          child: transactions.isEmpty
              ? NoTransaction()
              : ListView.builder(
                  itemBuilder: (_, index) =>
                      TransactionCard(transactions[index]),
                  itemCount: transactions.length,
                ),
        ),
      ],
    );
  }
}
