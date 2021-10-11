import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import './models/transaction.dart';
import './widgets/layouts/scaffold.dart';
import './widgets/transactions/buttons/add.dart';
import './widgets/transactions/chart.dart';
import './widgets/transactions/form.dart';
import './user_transactions.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.indigo[800],
        centerTitle: true,
      ),
      scaffoldBackgroundColor: CupertinoColors.white,
      // textTheme: CupertinoTextThemeData(textStyle: GoogleFonts.lemon()),
      primaryColor: CupertinoColors.activeBlue,
      // primarySwatch: Colors.blue,
    ),
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  void _submitNexTx(String title, double amount, DateTime date) {
    var id = (_transactions.length + 1).toString();
    var tx = Transaction(
      id: id,
      title: title,
      amount: amount,
      date: date,
    );
    setState(() {
      _transactions.add(tx);
    });
  }

  void _addNewTransaction(BuildContext ctx) {
    final callback = (String title, double amount, DateTime date) {
      _submitNexTx(title, amount, date);
      Navigator.of(context).pop();
    };

    showModalBottomSheet(
      context: ctx,
      builder: (_) => GestureDetector(
        onTap: () {},
        child: TransactionForm(_selectTransactionDate, callback),
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  void _deleteTransaction(String txId) {
    setState(() {
      // print('delete transaction: $txId');
      _transactions.removeWhere((tx) => tx.id == txId);
    });
  }

  void _selectTransactionDate(Function callback) {
    var now = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(Duration(days: 7)),
      lastDate: now,
    ).then((value) {
      if (value != null) {
        callback(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLanscaped = mediaQuery.orientation == Orientation.landscape;

    return MyAppScaffold(
      title: Text(
        'Personal Expenses',
        style: GoogleFonts.pacifico().apply(color: Colors.white),
        // padding: EdgeInsetsDirectional.only(bottom: 5, end: 5),
      ),
      trail: AddNewTxButton(() {
        print('adding new tx...');
        _addNewTransaction(context);
      }),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLanscaped)
              ChartVisibleSwitch(_showChart, (bool val) {
                setState(() {
                  print('set chart visibility: $val');
                  _showChart = val;
                });
              }),
            UserTransactions(
              !isLanscaped || _showChart,
              _transactions,
              _deleteTransaction,
            ),
          ],
        ),
      ),
    );
  }
}
