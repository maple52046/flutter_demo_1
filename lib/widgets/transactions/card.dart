import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_demo_1/models/transaction.dart';
import 'package:google_fonts/google_fonts.dart';

class _TxId extends StatelessWidget {
  final String txId;
  _TxId(this.txId);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      child: Text(txId),
    );
  }
}

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
            fontSize: 20,
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

// class _TxContent extends StatelessWidget {
//   final String title;
//   final DateTime date;
//   _TxContent(this.title, this.date);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _TxTitle(title),
//         _TxDate(date),
//       ],
//     );
//   }
// }

class TransactionCard extends StatelessWidget {
  final Transaction tx;

  TransactionCard(this.tx);

  @override
  Widget build(BuildContext context) {
    // return Card(
    //   child: Row(
    //     children: [
    //       _TxAmount(tx.amount),
    //       _TxContent(tx.title, tx.date),
    //     ],
    //   ),
    // );

    return Card(
      child: ListTile(
        leading: _TxId(tx.id),
        title: _TxTitle(tx.title),
        subtitle: _TxDate(tx.date),
        trailing: _TxAmount(tx.amount),
      ),
    );
  }
}
