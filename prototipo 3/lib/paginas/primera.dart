import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Product {
  String name;
  int quantity;
  File? image;

  Product({required this.name, required this.quantity, this.image});
}

class INVENTARIO extends StatefulWidget {
  const INVENTARIO({super.key});

  @override
  State<INVENTARIO> createState() => _INVENTARIOState();
}

class _INVENTARIOState extends State<INVENTARIO> {
  late TextEditingController controller;
  late TextEditingController cantidadController;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    cantidadController = TextEditingController();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    cantidadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INVENTARIO"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0), // Add vertical spacing between cards
              child: buildProductCard(products[index]),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: () async {
          final data = await AgregarProducto();
          if (data == null || data['name']!.isEmpty) return;

          setState(() {
            products.add(
              Product(
                name: data['name']!,
                quantity: int.parse(data['cantidad']!),
                image: data['image'],
              ),
            );
          });
        },
      ),
    );
  }

  Widget buildProductCard(Product product) {
    return Container(
      width: double.infinity,
      height: 290,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: product.image != null
                  ? Image.file(
                      product.image!,
                      width: double.infinity,
                      height: 170,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/images/sword.jpg",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
            ),
            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      product.name,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "Cantidad comprada: ${product.quantity}",
                      style: TextStyle(color: Colors.black54, fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "Inventario: ",
                      style: TextStyle(color: Colors.black54, fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "Precio de mercado: ",
                      style: TextStyle(color: Colors.black54, fontSize: 17),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> AgregarProducto() async {
    File? pickedImage;

    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Agregar Producto"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Referencia',
                hintText: "Ingrese la referencia",
                labelStyle: TextStyle(fontSize: 20, color: Colors.black),
              ),
              controller: controller,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Cantidad',
                hintText: "Ingrese la cantidad",
                labelStyle: TextStyle(fontSize: 20, color: Colors.black),
              ),
              controller: cantidadController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final pickedFile = await ImagePicker().getImage(
                  source: ImageSource.gallery,
                  imageQuality: 50,
                );
                if (pickedFile != null) {
                  pickedImage = File(pickedFile.path);
                }
              },
              child: Text("Añadir Imagen"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop({
                'name': controller.text,
                'cantidad': cantidadController.text,
                'image': pickedImage,
              });
            },
            child: Text(
              "Agregar",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
