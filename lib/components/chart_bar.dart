import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CharBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;
  String text;

  CharBar(this.label, this.value, this.percentage) {
    if (label == 'Mon') {
      text = 'Seg';
    }
    if (label == 'Tue') {
      text = 'Ter';
    }
    if (label == 'Wed') {
      text = 'Qua';
    }
    if (label == 'Thu') {
      text = 'Qui';
    }
    if (label == 'Fri') {
      text = 'Sex';
    }
    if (label == 'Sat') {
      text = 'Sab';
    }
    if (label == 'Sun') {
      text = 'Dom';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                '${value.toStringAsFixed(2)}',
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.60,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(text)),
          )
        ],
      );
    });
  }
}
