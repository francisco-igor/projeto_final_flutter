import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MyLogin.dart';
import '../HomePage.dart';
import 'dart:async';

class MyInitialPage extends StatefulWidget {
  const MyInitialPage({super.key});

  @override
  State<MyInitialPage> createState() => _MyInitialPageState();
}

class _MyInitialPageState extends State<MyInitialPage> {
  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyLoginPage()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
