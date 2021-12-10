import 'package:contactapp/STATE/CONTACTPROVIDER/contactscreen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateForm extends StatelessWidget {
  int index;

  UpdateForm({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactState>(
      builder: (BuildContext context, state, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Update Form')),
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
                            controller: state.textupdate1,
                            decoration: const InputDecoration(
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
                            controller: state.textupdate2,
                            decoration: InputDecoration(
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
                            controller: state.textupdate3,
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
                            controller: state.textupdate4,
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
                            // state.textadd1.text = state.textupdate1.text;
                            // state.textadd2.text = state.textupdate2.text;
                            // state.textadd3.text = state.textupdate3.text;
                            // state.textadd4.text = state.textupdate4.text;
                            state.updateFromDatabase(index, context);
                          },
                          child: const Text('Update'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
