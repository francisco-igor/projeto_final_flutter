import 'package:flutter/material.dart';
import '../view/Cep/CepPage.dart';
import '../view/Contacts/ContactList.dart';
import '../view/Login/InitialPage.dart';
import '../view/Maps/ContactMap.dart';
import '../view/HomePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyInitialPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/route': (context) => const HomePage(),
        '/contact': (context) => const ContactList(),
        '/map': (context) => const ContactMap(),
        '/cep': (context) => CepPage(),
        //'/category': (context) => const,
      },
    );
  }
}
