// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../model/repositories.dart';

class EditContact extends StatefulWidget {
  final int id;

  const EditContact({super.key, required this.id});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _locationController = TextEditingController();

  String? isNull(TextEditingController control) =>
      control.text.isEmpty ? null : control.text;

  void returnal() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 40, top: 50, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 90,
                child: ClipOval(
                  child: Image.network(
                    'https://cdn.icon-icons.com/icons2/2468/PNG/512/user_icon_149329.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Número',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _locationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CEP',
                  prefixIcon: Icon(Icons.location_history),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {
                    await UserDatabase().updateUser(
                      widget.id,
                      isNull(_nameController),
                      isNull(_numberController),
                      isNull(_locationController),
                    );
                    returnal();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
