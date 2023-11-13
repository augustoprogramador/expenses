import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('pt_BR');
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        't1', 'Tênis', 310.76, DateTime.now().subtract(Duration(days: 33))),
    Transaction(
        't2', 'Bermuda', 90.70, DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        't3', 'Camisa 1', 110.76, DateTime.now().subtract(Duration(days: 3))),
    Transaction('t4', 'Camisa 2', 110.76, DateTime.now()),
    Transaction('t5', 'Camisa 3', 110.76, DateTime.now()),
    Transaction('t6', 'Camisa 4', 110.76, DateTime.now()),
    Transaction('t7', 'Camisa 5', 110.76, DateTime.now()),
    Transaction('t7', 'Camisa 5', 110.76, DateTime.now()),
    Transaction('t7', 'Camisa 5', 110.76, DateTime.now()),
    Transaction('t7', 'Camisa 5', 110.76, DateTime.now()),
  ];

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          addTransaction: _addTransaction,
        );
      },
    );
  }

  _addTransaction(String title, double value, DateTime _selectedDate) {
    final newTransaction = Transaction(
      (Random().nextInt(50) + 50).toString(),
      title,
      value,
      _selectedDate,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      return _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  List<Transaction> get recentTransactions {
    return _transactions.where((el) {
      return el.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(fontSize: 20 * MediaQuery.of(context).textScaleFactor),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _openTransactionFormModal(context);
          },
        ),
      ],
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: availableHeight * 0.4,
                child: Chart(recentTransactions: recentTransactions)),
            Container(
              height: availableHeight * 0.6,
              child: TransactionList(
                transactions: _transactions,
                deleteTransaction: _deleteTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          _openTransactionFormModal(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
