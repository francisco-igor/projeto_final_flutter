// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Category/CategoryPage.dart';
import '../Cep/CepPage.dart';
import '../Contacts/ContactList.dart';
import '../HomePage.dart';
import '../Login/MyLogin.dart';
import '../Maps/ContactMap.dart';
import 'package:provider/provider.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = Provider.of<TextEditingController>(context);
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: null,
            accountEmail: Text("emailController.text"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn.icon-icons.com/icons2/2468/PNG/512/user_icon_149344.png"),
            ),
            decoration: BoxDecoration(
                color: Colors.teal,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://media.istockphoto.com/id/1372972509/photo/blue-green-background-dark-turquoise-gradient-hazy-painted-texture-with-black-bottom-and-teal.jpg?b=1&s=612x612&w=0&k=20&c=WFt06Man9DlhQojaCIeP41oduBP16CRNJ92HWHG0-cg='),
                  fit: BoxFit.fill,
                )),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Welcome'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('Contact'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactList(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Map'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactMap(),
                ),
              );
            },
          ),
          ListTile(
              leading: const Icon(Icons.location_pin),
              title: const Text('Cep'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CepPage(),
                  ),
                );
              }),
          ListTile(
            leading: const Icon(Icons.tag_rounded),
            title: const Text('Category'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CategorizedContactsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              final _firebaseAuth = FirebaseAuth.instance;
              _firebaseAuth.signOut().then((user) => Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(
                      builder: (context) => const MyLoginPage())));
            },
          ),
        ],
      ),
    );
  }
}
