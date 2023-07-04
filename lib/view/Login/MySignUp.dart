// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MyLogin.dart';

class MySingupPage extends StatefulWidget {
  const MySingupPage({super.key});

  @override
  State<MySingupPage> createState() => _MySingupPageState();
}

class _MySingupPageState extends State<MySingupPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  late bool _isHidden = true;

  void passwordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  signup() async {
    try {
      // Obtém as credenciais para criar uma nova conta
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // Conta criada com sucesso, faça a navegação para a próxima tela
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyLoginPage()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('O email já está sendo usado por outra conta!'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A senha é muito fraca!'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Instituto_Federal_do_Piau%C3%AD_-_Marca_Vertical_2015.svg/800px-Instituto_Federal_do_Piau%C3%AD_-_Marca_Vertical_2015.svg.png',
                  height: 200,
                ),
                const SizedBox(
                  height: 100,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                    hintText: 'nome@email.com',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.mail),
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Por favor, digite seu e-mail';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailController.text)) {
                      return 'Por favor, digite um e-mail válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: _isHidden,
                  decoration: InputDecoration(
                    label: const Text('Senha'),
                    hintText: 'Digite sua senha',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.key),
                    suffix: InkWell(
                      onTap: passwordView,
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  controller: _passwordController,
                  validator: (senha) {
                    if (senha == null || senha.isEmpty) {
                      return 'Por favor, digite sua senha';
                    } else if (senha.length < 6) {
                      return 'Por favor, digite uma senha com no mínimo 6 dígitos';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: _isHidden,
                  decoration: InputDecoration(
                    label: const Text('Confirmar Senha'),
                    hintText: 'Digite sua senha',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.key),
                    suffix: InkWell(
                      onTap: passwordView,
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  controller: _passwordConfirmController,
                  validator: (senha) {
                    if (senha == null || senha.isEmpty) {
                      return 'Por favor, digite sua senha';
                    } else if (senha.length < 6) {
                      return 'Por favor, digite uma senha com no mínimo 6 dígitos';
                    }
                    // Essa parte esta desativada, pq por algum motivo q desconheço ela aparece msm q as duas senhas sejam iguais, mas antes ela estva funcionando normalmente!
                    // else if(_passwordController != _passwordConfirmController){
                    //   return 'Por favor, digite a mesma senha';
                    // }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        signup();
                      }
                    },
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                  )
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MyLoginPage()
                      )
                    );
                  },
                  child: const Text('Já tenho usuário'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
