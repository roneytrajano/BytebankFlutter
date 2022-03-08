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

    if (response.statusCode == 200){
      return Transaction.fromJson(jsonDecode(response.body));
    }

    _throwHttpError(response.statusCode);

    return Transaction.fromJson(jsonDecode(response.body));

  }

  void _throwHttpError(int statusCode) => throw Exception(_statusCodeResponse[statusCode]);

  static final Map<int, String> _statusCodeResponse = {
    400 : 'there was an error submitting transaction',
    401 : 'authentication failed',
  };
}