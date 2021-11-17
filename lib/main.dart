import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screens/dashboard.dart';

void main() {
  runApp(const BytebankApp());
  // save(Contact(0,'roney',1000)).then((id){
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
    );
  }
}



