import 'package:bytebank/Models/Transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Models/Contacts.dart';
import 'Screens/dashboard.dart';
import 'database/dao/contacts_dao.dart';
import 'http/webclient.dart';

void main() {
  //save(Transaction(200.0, Contact(0, 'Roney', 2000))).then((value) => print(value));
  //findAll().then((value) => print('new transaction $value'));
  runApp(const BytebankApp());
  // final ContactsDao _contactDao = ContactsDao();
  // _contactDao.saveContact(Contact(0,'roney',1000)).then((id){
  //   findAll().then((value) => debugPrint(value.toString()));
  // });
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: const Dashboard(),
        // builder: EasyLoading.init(),
    );
  }
}



