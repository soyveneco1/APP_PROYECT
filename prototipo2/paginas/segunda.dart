import 'package:flutter/material.dart';

class PERSON extends StatefulWidget {
  const PERSON({super.key});

  @override
  State<PERSON> createState() => _PERSONState();
}

class _PERSONState extends State<PERSON> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTRO DE VENTAS"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
    );
  }
}
