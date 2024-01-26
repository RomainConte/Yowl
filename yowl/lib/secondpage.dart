
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Second page',
      home: SecondPage(),
    );
  }
}

class SecondPage extends StatelessWidget{
const SecondPage({Key? key}) : super(key: key);
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
backgroundColor: Colors.white,
elevation: 0,
leading:  IconButton(
icon: const Icon(
Icons.person,
color : Colors.black,
size: 40,
),
onPressed: () {
  Navigator.pop(context);
},
),
),
body: const Center(
child: Text('Second page'),
),
);
}
}