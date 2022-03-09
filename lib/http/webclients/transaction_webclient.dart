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

    throw HttpException(_statusCodeResponse[response.statusCode]);


  }

  static final Map<int, String> _statusCodeResponse = {
    400 : 'there was an error submitting transaction',
    401 : 'authentication failed',
  };
}

class HttpException implements Exception{
  //aqui tem uma exception expecifica que pode ser capturada no nosso error
  final String? message;

  HttpException(this.message);

}