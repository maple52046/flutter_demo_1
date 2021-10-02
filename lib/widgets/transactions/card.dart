import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy_demo_1/models/transaction.dart';
import './buttons/del.dart';

class _TxAmount extends StatelessWidget {
  final double amount;

  _TxAmount(this.amount);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.deepOrange,
          width: 2,
        ),
      ),
      child: Text(
        // '\$ ${amount.toStringAsFixed(2)}',
        '\$ $amount',
        style: GoogleFonts.mcLaren(
          textStyle: TextStyle(
            color: Colors.deepOrange,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _TxTitle extends StatelessWidget {
  final String title;
  _TxTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class _TxDate extends StatelessWidget {
  final DateTime date;
  _TxDate(this.date);

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat().format(date),
      style: TextStyle(color: Colors.grey),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Transaction tx;
  final Function onDelete;

  TransactionCard(this.tx, this.onDelete);

  @override
  Widget build(BuildContext context) {
    final isLandscaped = MediaQuery.of(context).size.width > 500;
    return Card(
      child: ListTile(
        leading: _TxAmount(tx.amount),
        title: _TxTitle(tx.title),
        subtitle: _TxDate(tx.date),
        trailing: DeleteTxButton(isLandscaped, () {
          onDelete(tx.id);
        }),
      ),
    );
  }
}
