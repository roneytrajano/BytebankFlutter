import 'dart:convert';

import 'package:bytebank/Models/Transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransactionWebClient{
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(url);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Transaction.fromJson(json)).toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    Map<String, dynamic> transactionMap = transaction.toJson();

    String jsonInput = jsonEncode(transactionMap);
    final Response response = await client.post(url, headers: {'Content-type': 'application/json', 'password': password,}, body: jsonInput);
    return Transaction.fromJson(jsonDecode(response.body));
  }
}