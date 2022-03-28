import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/contacts_list.dart';
import 'Screens/dashboard.dart';
import 'Screens/transactions_list.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

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
    return GetMaterialApp(
        theme: ThemeData.dark(),
        initialRoute: '/home',
        getPages: [
          GetPage(name: '/home', page: () => const Dashboard()),
          GetPage(name: '/transfer', page: () => const ContactsList()),
          GetPage(name: '/TransactionFeed', page: () => TransactionsList()),
        ],
        // builder: EasyLoading.init(),
    );
  }
}



