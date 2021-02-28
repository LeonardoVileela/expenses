import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'chart_bar.dart';
import 'package:expenses/components/transaction_list.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  final List<Transaction> transaction;

  Chart(this.recentTransaction, this.transaction);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.00;
      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMouth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMouth && sameYear)
          totalSum += recentTransaction[i].value;
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (previousValue, tr) {
      return previousValue + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Card()
        : Card(
            elevation: 6,
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: groupedTransactions.map((tr) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: CharBar(
                      tr['day'],
                      tr['value'],
                      (tr['value'] as double) / _weekTotalValue,
                    ),
                  );
                }).toList(),
              ),
            ),
          );
  }
}
