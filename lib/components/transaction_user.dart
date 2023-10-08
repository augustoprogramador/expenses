import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final List<Transaction> _transactions = [
    Transaction('t1', 'Tênis', 310.76, DateTime.now()),
    Transaction('t2', 'Bermuda', 90.70, DateTime.now()),
    Transaction('t3', 'Camisa 1', 110.76, DateTime.now()),
    Transaction('t4', 'Camisa 2', 110.76, DateTime.now()),
    Transaction('t5', 'Camisa 3', 110.76, DateTime.now()),
    Transaction('t6', 'Camisa 4', 110.76, DateTime.now()),
    Transaction('t7', 'Camisa 5', 110.76, DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      (Random().nextInt(50) + 50).toString(),
      title,
      value,
      DateTime.now(),
    );

    setState(() {
      print(newTransaction);
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(
          addTransaction: _addTransaction,
        ),
        TransactionList(transactions: _transactions),
      ],
    );
  }
}
