import 'package:contactapp/DATABASE/DBHELPER/contact_dbhepler.dart';
import 'package:contactapp/MODEL/CONTACT/contact_model.dart';
import 'package:flutter/cupertino.dart';

class ContactState extends ChangeNotifier {
  late final TextEditingController textadd1 = TextEditingController();
  final TextEditingController textadd2 = TextEditingController();
  final TextEditingController textadd3 = TextEditingController();
  final TextEditingController textadd4 = TextEditingController();

  late final TextEditingController textupdate1 = TextEditingController();
  final TextEditingController textupdate2 = TextEditingController();
  final TextEditingController textupdate3 = TextEditingController();
  final TextEditingController textupdate4 = TextEditingController();

  final formKey = GlobalKey<FormState>();
  int currentindex = 0;
  late List<Contact> data;
  late String Flag;
  ContactState() {
    data = [];
    Flag = 'add';
  }

  init() async {
    await DatabaseHelper.instance.database;
    getDataFromDatabase();
  }

  submitButton() async {
    insertDataToDatabase();
    textadd1.clear();
    textadd2.clear();
    textadd3.clear();
    textadd4.clear();
    print(Flag);
  }

  insertDataToDatabase() async {
    Contact contactdata = Contact(
        firstname: textadd1.text,
        lastname: textadd2.text,
        address: textadd3.text,
        phoneNumber: textadd4.text);
    DatabaseHelper.instance.insertContactData(contactdata).whenComplete(() {
      getDataFromDatabase();
    });
  }

  getDataFromDatabase() async {
    await DatabaseHelper.instance.getCollectionList().then((value) {
      data = value;
    });
    notifyListeners();
  }

  deleteFromDatabase(int id) async {
    await DatabaseHelper.instance
        .deleteContactByID(id)
        .whenComplete(() => getDataFromDatabase());
  }

  updateFromDatabase(int id, context) async {
    print(id);
    currentindex = id;
    Contact contactData = data[currentindex];
    contactData.firstname = textupdate1.text;
    contactData.lastname = textupdate2.text;
    contactData.address = textupdate3.text;
    contactData.phoneNumber = textupdate4.text;
    await DatabaseHelper.instance
        .updateContact(contactData.id!, contactData)
        .whenComplete(() => getDataFromDatabase());

    Navigator.pop(context);
    notifyListeners();
  }
}
