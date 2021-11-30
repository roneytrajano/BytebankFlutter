import 'package:bytebank/Models/Contacts.dart';
import 'package:bytebank/database/dao/contacts_dao.dart';
import 'package:flutter/material.dart';

class ContactsForm extends StatefulWidget {
  const ContactsForm({Key? key}) : super(key: key);

  @override
  State<ContactsForm> createState() => _ContactsFormState();
}

class _ContactsFormState extends State<ContactsForm> {
  final ContactsDao _contactDao = ContactsDao();

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
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _inputFullNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _inputAccountNumberController,
              decoration: const InputDecoration(
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
    final Contact newContact = Contact(0,_inputFullNameController.text,
        int.parse(_inputAccountNumberController.text));
    _contactDao.save(newContact);
    Navigator.pop(context);
  }
}
