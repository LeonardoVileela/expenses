import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'), // Thai
      ],
      home: MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.purple[600],
        accentColor: Colors.purple,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [];
  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _transaction.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  futureTransaction() {
    bool conditional = false;
    if (_transaction.length != 0) {
      for (int i = 0; i < _transaction.length; i++) {
        if (_transaction[i].date.year <= DateTime.now().year &&
            _transaction[i].date.month <= DateTime.now().month &&
            _transaction[i].date.day <= DateTime.now().day) {
          setState(() {
            conditional = true;
          });
          return conditional;
        } else {
          setState(() {
            return false;
          });
        }
      }
    }
    return false;
  }

  orientation() {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return isPortrait;
  }

  addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transaction.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transaction.removeWhere((element) => element.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text('Finanças'),
      actions: [
        if (!orientation())
          IconButton(
            icon: Icon(_showChart ? Icons.list : Icons.show_chart),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appbar,
      body: ListView(
        children: [
          orientation()
              ? futureTransaction()
                  ? Column(
                      children: [
                        Container(
                          height: availableHeight * 0.3,
                          child: Chart(_recentTransaction, _transaction),
                        ),
                        Container(
                          height: availableHeight * 0.7,
                          child:
                              TransactionList(_transaction, _removeTransaction),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          height: availableHeight,
                          child:
                              TransactionList(_transaction, _removeTransaction),
                        ),
                      ],
                    )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_showChart)
                      Container(
                        height: orientation()
                            ? availableHeight * 0.3
                            : availableHeight * 0.65,
                        child: Chart(_recentTransaction, _transaction),
                      ),
                    if (!_showChart)
                      Container(
                        height: availableHeight * 1,
                        child:
                            TransactionList(_transaction, _removeTransaction),
                      ),
                  ],
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
