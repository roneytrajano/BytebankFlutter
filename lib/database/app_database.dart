import 'package:bytebank/database/dao/contacts_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactsDao.sql);
    },
    version: 1,
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}


