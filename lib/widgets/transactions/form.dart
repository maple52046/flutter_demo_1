import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:udemy_demo_1/widgets/typographies/titles.dart';
import './fields.dart';
import './buttons/submit.dart';

class _FormLabel extends StatelessWidget {
  final String label;
  _FormLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      alignment: Alignment.centerRight,
      child: Text(
        '$label:',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _FormTextField extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final TextInputType? inputType;

  _FormTextField({
    required this.controller,
    required this.placeholder,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    final TextInputType kt =
        (inputType != null) ? inputType as TextInputType : TextInputType.text;
    return Expanded(
      child: NewTxTextField(placeholder, controller, kt),
    );
  }
}

class _TransactionFormRow extends StatelessWidget {
  final String label;
  final Widget child;

  _TransactionFormRow({
    required this.label,
    required this.child,
  });

  Widget build(BuildContext context) {
    return Container(
      key: Key(label.toLowerCase()),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _FormLabel(label),
          child,
        ],
      ),
    );
  }
}

class TransactionForm extends StatefulWidget {
  final Function pickDate;
  final Function newTx;
  TransactionForm(this.pickDate, this.newTx);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime date = DateTime.now();

  void setTxDate(DateTime val) {
    setState(() {
      date = val;
    });
  }

  void submit() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    widget.newTx(title, amount, date);
    titleController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final calendarToday =
        Platform.isIOS ? CupertinoIcons.calendar_today : Icons.calendar_today;

    return Card(
      elevation: 5,
      child: Container(
        height: double.infinity,
        // padding: EdgeInsets.only(
        //     bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Title22('New Transaction'),
            ),
            _TransactionFormRow(
              label: 'Title',
              child: _FormTextField(
                controller: this.titleController,
                placeholder: '(The item you pay for)',
              ),
            ),
            _TransactionFormRow(
              label: 'Amount',
              child: _FormTextField(
                controller: amountController,
                placeholder: '(How much you cost)',
                inputType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            _TransactionFormRow(
              label: 'Date',
              child: Row(
                children: [
                  Text(DateFormat().format(date)),
                  IconButton(
                    icon: Icon(calendarToday),
                    onPressed: () {
                      widget.pickDate(setTxDate);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: SubmitNewTxButton(submit),
            ),
          ],
        ),
      ),
    );
  }
}
