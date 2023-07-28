import "package:flutter/material.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'paginas/primera.dart';
import 'paginas/segunda.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _paginaactual = 0;
  List<Widget> paginas = [INVENTARIO(), PERSON()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginas[_paginaactual],
      backgroundColor: Colors.black,
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        onTap: (index) {
          setState(() {
            _paginaactual = index;
          });
        },
        items: [
          Icon(Icons.inventory, color: Colors.white),
          Icon(Icons.store_mall_directory_sharp, color: Colors.white),
          Icon(Icons.add, color: Colors.white),
          Icon(Icons.album, color: Colors.white),
          Icon(Icons.assessment, color: Colors.white),
        ],
        color: Colors.black,
        backgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 200),
      ),
    );
  }
}
