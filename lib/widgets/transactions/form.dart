import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:udemy_demo_1/widgets/text_title.dart';

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
          color: CupertinoColors.black,
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
    return CupertinoTextField(
      placeholder: placeholder,
      placeholderStyle: TextStyle(
        fontSize: 20,
        color: CupertinoColors.systemGrey,
      ),
      style: TextStyle(
        fontSize: 20,
        color: CupertinoColors.black,
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
      ),
      controller: controller,
      keyboardType: kt,
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
          color: CupertinoColors.lightBackgroundGray,
          width: 1,
        ),
      ),
      child: CupertinoFormRow(
        prefix: _FormLabel(label),
        child: child,
      ),
    );
  }
}

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  // final Function enableDatePicker;
  final Function newTxCallback;

  TransactionForm(this.newTxCallback);

  void submit() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    newTxCallback(title, amount);
    titleController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        height: 550,
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
              child: CupertinoButton(
                child: Text('pick'),
                onPressed: () {},
              ),
            ),
            CupertinoButton(
              child: Text('Add Transcation'),
              onPressed: submit,
            ),
          ],
        ),
      ),
    );
  }
}
