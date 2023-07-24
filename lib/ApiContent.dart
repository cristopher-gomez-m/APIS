import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apis/Cat.dart';
class ApiContentPage extends StatefulWidget {
  @override
  _ApiContentPageState createState() => _ApiContentPageState();
}


class _ApiContentPageState extends State<ApiContentPage> {
  List<Cat> _cats = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCats();
  }

 Future<void> _fetchCats() async {
    try {
      final response = await http.get(Uri.parse('https://api.thecatapi.com/v1/images/search?limit=10'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _cats = data.map((catData) => Cat(
            id: catData['id'],
            url: catData['url'],
            width: catData['width'],
            height: catData['height'],
          )).toList();
          _isLoading = false;
        });
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Error al obtener los datos de la API de gatos.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Error al conectarse a la API de gatos: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gatos Adorables'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _cats.length,
              itemBuilder: (context, index) {
                final cat = _cats[index];
                return ListTile(
                  leading: Image.network(cat.url),
                  title: Text('Gato ${cat.id}'),
                  subtitle: Text('Ancho: ${cat.width}, Alto: ${cat.height}'),
                );
              },
            ),
    );
  }
}
