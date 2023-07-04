// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../model/repositories.dart';
import '../Drawer/Drawer.dart';
import 'InfoPage.dart';
import 'AddContact.dart';
import 'EditContact.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<Map<String, dynamic>> _users = [];

  Future<void> _list() async {
    _users = await UserDatabase().getUsers();
    setState(() {});
  }

  void _route(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    ).then((_) {
      _list();
    });
  }

  @override
  void initState() {
    super.initState();
    _list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
        actions: [
          IconButton(
            onPressed: () async {
              await UserDatabase().eraseDatabase();
              setState(() {
                _users = [];
              });
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      drawer: const SideBar(),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          child: ListView.builder(
            itemCount: _users.isEmpty ? 1 : _users.length * 2 - 1,
            itemBuilder: (context, index) {
              if (index.isOdd) {
                return Container(
                  margin: const EdgeInsets.all(15),
                  child: const Divider(
                    height: 1,
                    color: Colors.black38,
                  ),
                );
              } else {
                final itemIndex = index ~/ 2;
                if (itemIndex < _users.length) {
                  final contact = _users[itemIndex];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: ClipOval(
                            child: Image.asset(
                              'images/user.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(contact['name']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _route(EditContact(id: contact['id']));
                              },
                              icon: const Icon(Icons.edit),
                              color: Colors.yellow[400],
                            ),
                            IconButton(
                              onPressed: () async {
                                await UserDatabase().deleteUser(contact['id']);
                                _list();
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red[400],
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InfoPage(
                                user: contact,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 250),
                      Text(
                        'Você não tem contatos salvos',
                        style: TextStyle(color: Colors.black45, fontSize: 20),
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _route(const AddContact());
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
