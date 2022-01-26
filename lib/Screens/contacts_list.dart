import 'package:bytebank/Components/Progress.dart';
import 'package:bytebank/Models/Contacts.dart';
import 'package:bytebank/Screens/contacts_form.dart';
import 'package:bytebank/database/dao/contacts_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:bytebank/Screens/transaction_form.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactsDao _contactDao = ContactsDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
          initialData: const [],
          future: _contactDao.findAll(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // EasyLoading.show(status: 'loading...');
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contact> contacts = snapshot.data;
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    final Contact contact = contacts[index];
                    return _ContactItemCard(contact: contact, onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionForm(contact)));
                    },);
                  },
                  itemCount: contacts.length,
                );
            }

            return const Text('Erro desconhecido');
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => const ContactsForm(),
              ))
              .then((value) => setState(() {}));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

// class CustomAnimation extends EasyLoadingAnimation {
//   CustomAnimation();
//
//   @override
//   Widget buildWidget(
//     Widget child,
//     AnimationController controller,
//     AlignmentGeometry alignment,
//   ) {
//     return Opacity(
//       opacity: controller.value,
//       child: RotationTransition(
//         turns: controller,
//         child: child,
//       ),
//     );
//   }
// }

class _ContactItemCard extends StatelessWidget {

   _ContactItemCard({Key? key, required this.contact, required this.onClick()}) : super(key: key);

  final ContactsDao _contactDao = ContactsDao();

  final Contact contact;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contact.name,
          style: const TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(fontSize: 16.0),
        ),
        leading:
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {

            _contactDao.deleteContact(contact.id);
          },
        ),
      ),
    );
  }
}
