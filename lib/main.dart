import 'package:flutter/material.dart';
import 'package:atv1/infoInput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _error = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool? pass;
   Future<void> login() async {
    try{
      final response = await http.get(Uri.parse("http://172.20.0.1:6060/users?name=${_name.text}&password=${_password.text}"));
      var item = json.decode(response.body);
      if(item.length==1){
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const infoInput()),(Route<dynamic> route) => false,);
      }

    }
    catch(e){
      setState(() {
        _error.text = "Não foi possivel logar";
        pass = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                decoration:
                    const InputDecoration(labelText: "Digite seu nome"),
                style: const TextStyle(fontSize: 20),
                controller: _name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: "Senha"),
                style: const TextStyle(fontSize: 20),
                controller: _password,
              ),
            ),
            ElevatedButton(
                onPressed:(){login();},
                child: const Text("Enviar")),
          Text(_error.text)
          ],
        ),
      ),
    );
  }
}