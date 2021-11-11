import 'package:bytebank/Screens/contacts_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ListView(
        children: const [
          Card(
            child: ListTile(
              title: Text(
                'Roney',
                style: TextStyle(fontSize: 24.0),
              ),
              subtitle: Text('100', style: TextStyle(fontSize: 16.0)),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => ContactsForm(),
              ))
              .then(
                (value) => debugPrint('$value'),
              );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
