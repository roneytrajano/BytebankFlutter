// ignore: file_names
// ignore_for_file: file_names

import 'Contacts.dart';

class Transaction {
  final double value;
  final Contact contact;

  Transaction(
      this.value,
      this.contact,
      );

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }

  Transaction.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        contact = Contact.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
    'value': value,
    'contact': contact.toJson(),

  };

}