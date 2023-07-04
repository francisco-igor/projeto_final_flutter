// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Drawer/Drawer.dart';

class CepPage extends StatefulWidget {
  @override
  _CepPageState createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {
  List<String> consultasRealizadas = [];
  Map<String, dynamic> endereco = {};

  final cepController = TextEditingController();

  Future<void> consultarCEP(String? cep) async {
    final response =
        await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    if (response.statusCode == 200) {
      setState(() {
        endereco = jsonDecode(response.body);
        if (cep != null) {
          consultasRealizadas.add(cep);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de CEP'),
      ),
      drawer: const SideBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                controller: cepController,
                decoration: const InputDecoration(
                  labelText: 'Digite o CEP',
                  prefixIcon: Icon(Icons.location_pin),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Consultar'),
                onPressed: () {
                  consultarCEP(cepController.text);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Consultas Realizadas:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: consultasRealizadas.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Card(
                        child: ListTile(
                          title: Text(consultasRealizadas[index]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetalhesConsulta(
                                  cep: consultasRealizadas[index],
                                  endereco: endereco,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetalhesConsulta extends StatelessWidget {
  final String cep;
  final Map<String, dynamic> endereco;

  const DetalhesConsulta(
      {super.key, required this.cep, required this.endereco});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Consulta'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://m.media-amazon.com/images/I/51WcUuvChzL.png',
                height: 200,
              ),
              const SizedBox(height: 20),
              Text(
                'CEP: $cep',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Logradouro: ${endereco['logradouro']}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                'Bairro: ${endereco['bairro']}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                'Cidade: ${endereco['localidade']}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                'Estado: ${endereco['uf']}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
