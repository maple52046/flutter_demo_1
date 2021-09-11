import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy_demo_1/user_transactions.dart';

import 'models/transaction.dart';
import 'widgets/transactions/form.dart';

void main() => runApp(CupertinoApp(
      theme: CupertinoThemeData(
        barBackgroundColor: Colors.indigo[800],
        scaffoldBackgroundColor: CupertinoColors.white,
        // textTheme: CupertinoTextThemeData(textStyle: GoogleFonts.lemon()),
      ),
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];

  void _submitNexTx(String title, double amount) {
    var id = (_transactions.length + 1).toString();
    var tx = Transaction(
      id: id,
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    setState(() {
      _transactions.add(tx);
    });
  }

  void _addNewTransaction(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => GestureDetector(
        onTap: () {},
        child: TransactionForm((String title, double amount) {
          _submitNexTx(title, amount);
          Navigator.of(context).pop();
        }),
      ),
    );
  }

  // void _selectTransactionDate() {
  //   var now = DateTime.now();
  //   showDatePicker(
  //     context: context,
  //     initialDate: now,
  //     firstDate: now.subtract(Duration(days: 7)),
  //     lastDate: now,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Personal Expenses',
          style: GoogleFonts.pacifico(),
        ),
        padding: EdgeInsetsDirectional.only(bottom: 5, end: 5),
        trailing: CupertinoButton(
          child: Icon(
            CupertinoIcons.add,
            color: CupertinoColors.white,
          ),
          padding: EdgeInsetsDirectional.only(bottom: 5),
          onPressed: () => _addNewTransaction(context),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: UserTransactions(_transactions),
        ),
      ),
    );
  }
}
