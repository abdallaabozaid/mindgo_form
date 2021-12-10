import 'package:flutter/material.dart';
import 'package:mindgo_form/form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mindgo Formm',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: FormScreen(),
    );
  }
}
