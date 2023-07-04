// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Category/CategoryPage.dart';
import 'Cep/CepPage.dart';
import 'Contacts/ContactList.dart';
import 'Drawer/Drawer.dart';
import 'Login/MyLogin.dart';
import 'Maps/ContactMap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firebaseAuth = FirebaseAuth.instance;

  sair() async {
    await _firebaseAuth.signOut().then(
      (user) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyLoginPage())
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App de Contatos',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              sair();
            }, 
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      drawer: const SideBar(),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 10, top: 50, right: 10),
          child: Column(
            children: [
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Instituto_Federal_do_Piau%C3%AD_-_Marca_Vertical_2015.svg/800px-Instituto_Federal_do_Piau%C3%AD_-_Marca_Vertical_2015.svg.png',
                height: 200,
              ),

              const SizedBox(height: 142),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 125,
                    width: 165,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactList(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text('Contatos'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 125,
                    width: 165,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactMap(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text('Mapas'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 125,
                    width: 165,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CepPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text('CEP'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 125,
                    width: 165,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategorizedContactsPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text('Categoria'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
