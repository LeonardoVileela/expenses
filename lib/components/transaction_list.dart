import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function onDelete;

  TransactionList(this.transaction, this.onDelete);
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Nenhuma Transação Cadastrada',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.50,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (ctx, index) {
              final tr = transaction[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          'R\$ ' + tr.value.toStringAsFixed(2),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat('dd/MM/y').format(tr.date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => onDelete(tr.id),
                  ),
                ),
              );
            },
          );
  }
}



/*Text(
  tr.title,
  style: Theme.of(context).textTheme.headline6,
),
Text(
  DateFormat('dd/MM/y').format(tr.date),
  style: TextStyle(color: Colors.grey[600]),
)*/

/*
Text(
  'R\$ ' + tr.value.toStringAsFixed(2),
  style: TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: Theme.of(context).primaryColor,
  ),
),
*/ 