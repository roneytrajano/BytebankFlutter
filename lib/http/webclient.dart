import 'dart:convert';

import 'package:bytebank/Models/Contacts.dart';
import 'package:bytebank/Models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

Client client = InterceptedClient.build(interceptors: [
  LoggingInterceptor(),
]);

final Uri url = Uri.parse('http://192.168.0.101:8080/transactions');


class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(data.statusCode);
    print(data.headers);
    print(data.body);
    return data;
  }

}

Future<List<Transaction>> findAll() async {
  final Response response = await client.get(url);
  List<dynamic> decodedJson = jsonDecode(response.body);

  final List<Transaction> Transactions = [];

  for (Map<String, dynamic> element in decodedJson) {
    final double value = element['value'];
    final String name = element['contact']['name'];
    final int accountNumber = element['contact']['accountNumber'];
    final Contact contact = Contact(0, name, accountNumber);

    Transactions.add(Transaction(value, contact));
  }

  return Transactions;
}

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value' : transaction.value,
    'contact' : {
      'name' : transaction.contact.name,
      'accountNumber' : transaction.contact.accountNumber
    }
  };

  String jsonInput = jsonEncode(transactionMap);
  final Response response = await client.post(url, headers: {'Content-type': 'application/json', 'password': '1000',}, body: jsonInput);
  Map<String, dynamic> jsonRetorno = jsonDecode(response.body);


  return Transaction(jsonRetorno['value'], Contact(0, jsonRetorno['name'], jsonRetorno['accountNumber']));
}