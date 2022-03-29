import 'dart:async';

import 'package:bytebank/Components/autentica%C3%A7%C3%A3o_transferencia.dart';
import 'package:bytebank/Components/progress.dart';
import 'package:bytebank/Components/response_dialog.dart';
import 'package:bytebank/Models/Contacts.dart';
import 'package:bytebank/Models/Transaction.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();
  bool _validate = false;
  bool _seding = false;

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _seding,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Progress(),
                ),
              ),
              Text(
                widget.contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(
                    labelText: 'Value',
                    errorText: _validate ? 'Value Can\'t Be Empty' : null,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      setState(() {
                        _valueController.text.isEmpty ? _validate = true : _validate = false;
                      });
                      if(_validate == false) {
                        //oq eh exatamente esse contextDialog
                        showDialog(
                            context: context,
                            builder: (contextDialog) {
                              return AutenticacaoTransferencia(
                                  onConfirm: (String password) {
                                    final double? value =
                                    double.tryParse(_valueController.text);
                                    final transactionCreated =
                                    Transaction(transactionId, value!, widget.contact);
                                    _save(transactionCreated, password, context);
                                  });
                            });
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(Transaction transactionCreated, String password, BuildContext context) async {
    setState(() {
      _seding = true;
    });
   final Transaction transaction = await _webClient.save(transactionCreated, password)
       .catchError((e) {
     if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
       // Collection is enabled.
       // FirebaseCrashlytics.instance.setCustomKey('exception', e.toString());
       // FirebaseCrashlytics.instance.setCustomKey('http_body', transactionCreated.toString());
       FirebaseCrashlytics.instance.recordError(e, null);
     }
     showDialog(context: context, builder: (contextDialog) => FailureDialog('timeout submitting the transaction'));
   }, test: (e) => e is TimeoutException)
       .catchError((e) {
     if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
       // Collection is enabled.
       FirebaseCrashlytics.instance.setCustomKey('exception', e.toString());
       FirebaseCrashlytics.instance.recordError(e, null);
     }


     showDialog(context: context, builder: (contextDialog) => FailureDialog(e.message));
   }, test: (e) => e is HttpException)
       .catchError((e) {
     if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
       // Collection is enabled.
       FirebaseCrashlytics.instance.setCustomKey('exception', e.toString());
       FirebaseCrashlytics.instance.setCustomKey('http_code', e.statusCode);
       FirebaseCrashlytics.instance.recordError(e, null);
     }

     showDialog(context: context, builder: (contextDialog) => FailureDialog('unknown error'));
   }, test: (e) => e is Exception).whenComplete(() {
     setState(() {
       _seding = false;
     });
   });

    if (transaction != null) {
      await showDialog(context: context, builder: (contextDialog) => SuccessDialog("sucessful transaction"));
      Navigator.pop(context);
    }

  }
}
