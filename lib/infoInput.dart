import 'package:flutter/material.dart';
import 'package:atv1/showData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class infoInput extends StatefulWidget {
  const infoInput({super.key});

  @override
  State<infoInput> createState() => _infoInputState();
}

class _infoInputState extends State<infoInput> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  Future<void> createProduct() async {
   try{
     var response = await http.post(Uri.parse("http://172.20.0.1:6060/produtos"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": _name.text,
          "price": _price.text,
        }));
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const showData()),(Route<dynamic> route) => false,);
   }catch(e){
    print("ok");
   }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prencha o formulario"),
      ),
     body: Column(
      children: [
             Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                decoration:
                    const InputDecoration(labelText: "Digite o nome do seu produto"),
                style: const TextStyle(fontSize: 20),
                controller:_name ,
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: "Digite o valor do seu produto"),
                style: const TextStyle(fontSize: 20),
                controller:_price,
              ),
            ),
            ElevatedButton(onPressed: (){
              createProduct();
            }, child: const Text("Enviar")),
      ],
     ),

      );
    
  }
}