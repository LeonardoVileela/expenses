import 'package:flutter/cupertino.dart';

class Transaction {
  String id;
  String title;
  double value;
  DateTime date;

  Transaction(
      {@required this.id,
      @required this.title,
      @required this.value,
      @required this.date});
}
