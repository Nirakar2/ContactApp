import 'package:contactapp/STATE/CONTACTPROVIDER/contactscreen_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact2_screen.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ContactState>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactState>(
      builder: (BuildContext context, state, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Contact Us')),
          ),
          body: SizedBox(
            height: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: state.textadd1,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(),
                              hintText: 'First Name',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: state.textadd2,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(),
                              hintText: 'Last Name',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: state.textadd3,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(),
                              hintText: 'Address',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: state.textadd4,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(),
                              hintText: 'Contact',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            state.submitButton();
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ContactList(index: index, state: state);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ContactList extends StatelessWidget {
  ContactState state;
  int index;

  ContactList({Key? key, required this.state, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.blueGrey,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "${state.data[index].firstname}  ${state.data[index].lastname}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Text(state.data[index].address),
                Text(state.data[index].phoneNumber),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Divider(
              indent: 10,
              endIndent: 10,
              color: Colors.blueGrey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            launch('tel://${state.data[index].phoneNumber}');
                          },
                          child: const Text('Call',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16))),
                      TextButton(
                          onPressed: () {
                            state.textupdate1.text =
                                state.data[index].firstname;
                            state.textupdate2.text = state.data[index].lastname;
                            state.textupdate3.text = state.data[index].address;
                            state.textupdate4.text =
                                state.data[index].phoneNumber;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateForm(
                                          index: index,
                                        )));
                          },
                          child: const Text('Update',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16))),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    state.deleteFromDatabase(state.data[index].id!);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Remove',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
