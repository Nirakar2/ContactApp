import 'dart:io';
import 'package:contactapp/MODEL/CONTACT/contact_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbVersion = 1;
  // database name
  static const _dbName = 'contactdb';

  //Table Name Decleration
  static const tableName = "contact_info";

  //Table heading Name
  static const columnName1 = "ID";
  static const columnName2 = "FirstName";
  static const columnName3 = "LastName";
  static const columnName4 = "Address";
  static const columnName5 = "PhoneNumber";

  // defined for DB helper
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initiateDatabase();
    return _database;
  }

  late String path;
  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: onCreate);
  }

  Future<void> onCreate(Database db, int version) async {
    // Create Table and Column
    await db.execute(''' CREATE TABLE if not exists $tableName(
                                                $columnName1 INTEGER PRIMARY KEY AUTOINCREMENT,                                  
                                                $columnName2 TEXT,
                                                $columnName3 TEXT,
                                                $columnName4 TEXT,
                                                $columnName5 TEXT) ''');
  }

  Future<bool> insertContactData(Contact contact) async {
    final Database db = await _initiateDatabase();
    db.insert(tableName, contact.toMap());
    return true;
  }

  Future<dynamic> deleteContactByID(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(tableName, where: columnName1 + "=?", whereArgs: [id]);
  }

  Future<int> updateContact(int id, Contact contact) async {
    // returns the number of rows updated
    final db = await instance.database;
    return await db!.update(tableName, contact.toMap(),
        where: columnName1 + "= ?", whereArgs: [id]);
  }

  //get all the items of the table
  Future<List<Map<String, dynamic>>> getCollectionMapList() async {
    Database? db = await instance.database;
    // return await db!.query(collectionListTable, orderBy: "pkID DESC");
    return await db!.rawQuery('''select * from $tableName''');
  }

  Future<List<Contact>> getCollectionList() async {
    List<Map<String, dynamic>> customerUpdatedMapList =
        await getCollectionMapList();
    List<Contact> customerUpdatedList = <Contact>[];
    for (var entry in customerUpdatedMapList) {
      customerUpdatedList.add(Contact(
        id: entry['ID'],
        address: entry['Address'],
        phoneNumber: entry['PhoneNumber'],
        lastname: entry['LastName'],
        firstname: entry['FirstName'],
      ));
    }
    return customerUpdatedList;
  }
}
