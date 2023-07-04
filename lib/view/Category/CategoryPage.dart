import 'package:flutter/material.dart';

import '../Drawer/Drawer.dart';

class Contact {
  final String name;
  final String email;
  final List<String> tags;

  Contact({required this.name, required this.email, required this.tags});
}

class CategorizedContactsPage extends StatefulWidget {
  @override
  _CategorizedContactsPageState createState() =>
      _CategorizedContactsPageState();
}

class _CategorizedContactsPageState extends State<CategorizedContactsPage> {
  List<Contact> contacts = [
    Contact(
        name: 'John Doe',
        email: 'john.doe@example.com',
        tags: ['Friend', 'Work']),
    Contact(
        name: 'Jane Smith', email: 'jane.smith@example.com', tags: ['Family']),
    Contact(
        name: 'Bob Johnson', email: 'bob.johnson@example.com', tags: ['Work']),
  ];

  List<String> selectedTags = [];

  List<String> getAllTags() {
    List<String> allTags = [];
    for (var contact in contacts) {
      allTags.addAll(contact.tags);
    }
    return allTags.toSet().toList();
  }

  List<Contact> getFilteredContacts() {
    if (selectedTags.isEmpty) {
      return contacts;
    } else {
      return contacts
          .where((contact) =>
              contact.tags.any((tag) => selectedTags.contains(tag)))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorized Contacts'),
      ),
      drawer: const SideBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8.0,
              children: getAllTags().map((tag) {
                bool isSelected = selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        selectedTags.add(tag);
                      } else {
                        selectedTags.remove(tag);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getFilteredContacts().length,
              itemBuilder: (context, index) {
                Contact contact = getFilteredContacts()[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.email),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
