import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_demo_1/models/transaction.dart';
import 'package:udemy_demo_1/widgets/text_title.dart';

class _ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentage;

  _ChartBar(this.label, this.amount, this.percentage);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\$${amount.toStringAsFixed(0)}'),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration:
                      BoxDecoration(color: CupertinoColors.systemYellow),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}

class TransactionChart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  TransactionChart(this.recentTransactions);

  List<Map<String, Object>> get groupedTxValues {
    return List.generate(7, (index) {
      final wd = DateTime.now().subtract(Duration(days: index));
      double amount = 0.0;

      for (var tx in recentTransactions) {
        final d = tx.date;
        if (d.day == wd.day && d.month == wd.month && d.year == wd.year) {
          amount += tx.amount;
        }
      }

      return {
        // 'day': DateFormat.E().format(wd).substring(0, 1),
        'day': DateFormat.E().format(wd),
        'amount': amount,
      };
    }).reversed.toList();
  }

  double get total {
    return groupedTxValues.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Title22('Cost Board'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTxValues.map((v) {
                final day = v['day'] as String;
                final amount = v['amount'] as double;
                final pct = (total > 0) ? amount / total : total;
                return Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: _ChartBar(day, amount, pct),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
