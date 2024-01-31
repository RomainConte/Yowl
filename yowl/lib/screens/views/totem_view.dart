import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yowl/static.dart';

class TotemView extends StatelessWidget {
  const TotemView({Key? key});

  Future<List<dynamic>> fetchAnimals() async {
    final response =
        await http.get(Uri.parse('http://$ipAdress/api/animals/1'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData.containsKey('data')) {
        return List<dynamic>.from(responseData['data']);
      } else {
        throw Exception('Expected key "data" not found in response');
      }
    } else {
      throw Exception('Failed to load animals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animals'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchAnimals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else if (snapshot.hasData) {
            final animalsList = snapshot.data as List<dynamic>;

            return ListView.builder(
              itemCount: animalsList.length,
              itemBuilder: (context, index) {
                final animals = animalsList[index]['attributes'];

                return ListTile(
                  title: Text('Name: ${animals['name']}'),
                  subtitle: Text('Vmax: ${animals['vmax']}'),
                );
              },
            );
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
