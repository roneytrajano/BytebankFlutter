import 'package:bytebank/Models/Contacts.dart';
import 'package:flutter/material.dart';

class ContactsForm extends StatefulWidget {
  const ContactsForm({Key? key}) : super(key: key);

  @override
  State<ContactsForm> createState() => _ContactsFormState();
}

class _ContactsFormState extends State<ContactsForm> {
  final TextEditingController _inputFullNameController =
      TextEditingController();

  final TextEditingController _inputAccountNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New contact'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _inputFullNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full name',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _inputAccountNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Account number',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: ElevatedButton(
                  onPressed: () => onPressed(context),
                  child: const Text(
                    'Create',
                    style: TextStyle(fontSize: 16),
                  )),
              width: double.maxFinite,
            ),
          ),
        ],
      ),
    );
  }

  void onPressed(BuildContext context) {
    final Contact NewContact = Contact(0,_inputFullNameController.text,
        int.parse(_inputAccountNumberController.text));
    Navigator.pop(context, NewContact);
  }
}
