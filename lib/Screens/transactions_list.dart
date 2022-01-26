import 'package:bytebank/Components/Progress.dart';
import 'package:bytebank/Components/centered_message.dart';
import 'package:bytebank/Models/Contacts.dart';
import 'package:bytebank/Models/Transaction.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
   //transactions.add(Transaction(100.0, Contact(0, 'Alex', 1000)));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transactions'),
        ),
        body: FutureBuilder<List<Transaction>>(
          future: findAll(),

          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {


            switch(snapshot.connectionState){

              case ConnectionState.none:
                // TODO: Handle this case.
                break;
              case ConnectionState.waiting:
                return Progress();
                break;
              case ConnectionState.active:
                // TODO: Handle this case.
                break;
              case ConnectionState.done:
                final List<Transaction> transactions = snapshot.data;
                if(transactions.isNotEmpty){
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];

                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.accountNumber.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transactions.length,
                  );
                }
                return CenteredMessage('No transactions found', icon: Icons.warning);

            }
          return CenteredMessage('Erro desconhecido');


          },
        ));
  }
}
