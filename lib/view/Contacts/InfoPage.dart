// ignore_for_file: file_names
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  final Map<String, dynamic> user;

  const InfoPage({super.key, required this.user});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final List<Widget> textos = [
    const Text('Nome: ',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    const Text('Número: ',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    const Text('CEP: ',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações do Contato'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 30, top: 50, right: 30),
          child: Column(
            children: <Widget>[
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
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    textos[0],
                    Text(widget.user['name'].toString(),
                        style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              Container(
                width: 300,
                height: 50,
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.black, width: 1.5),
                    right: BorderSide(color: Colors.black, width: 1.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    textos[1],
                    Text(
                      widget.user['number'].toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    textos[2],
                    Text(
                      widget.user['location'].toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
