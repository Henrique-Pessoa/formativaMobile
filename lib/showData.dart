import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class showData extends StatefulWidget {
  const showData({super.key});

  @override
  State<showData> createState() => _showDataState();
}

class _showDataState extends State<showData> {
  var arrNames = [];
  var arrPrices = [];
  String?_name;
  login() async {
      try{
        final response = await http.get(Uri.parse("http://172.20.0.1:6060/produtos"));
        var item = json.decode(response.body);
        arrNames.add(item);
      }catch(e){
        print(e);
      }
  }
  @override
  Widget build(BuildContext context) {
    login();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prencha o formulario"),
      ),
     body: Column(
      children: [
             Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                "${arrNames}")
            ),
      ],
     ),

      );
    
  }
}