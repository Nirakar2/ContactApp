import 'package:contactapp/Screen/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'STATE/CONTACTPROVIDER/contactscreen_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ContactState())],
      child: MaterialApp(
        home: Contact(),
      ),
    );
  }
}
