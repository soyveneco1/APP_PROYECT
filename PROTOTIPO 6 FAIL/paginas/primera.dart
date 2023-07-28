import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

// Las credenciales de GSheets se mantienen igual...
const _credenciales = {
  "type": "service_account",
  "project_id": "margaritas-393420",
  "private_key_id": "5a7de605c675e88345b663b30d2568b614111ed9",
  "private_key":
      "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDT9lEbbbu6s/oj\n+cXhvUMJGkXEVCuf3GKMWGSB33QiFEJ6/rWHMoxLekeuw5BA37gQEm/7SA/2hiAm\nEUYIpn/PpjvMmTAVKJPylEyxTI//FqwlsHwSimOu7ihXFqhRSb/Pq+v4TTWPteyD\nW6o9GHcmYi0+dkLSLMwtQtSCTUCewCndR1eR22h7mCP7Op3u7/EZ7uixw59M5yKt\nmkyEmbfPmx9bZbZwLCZJC3jYqzD8awvqP9VxJZz6s5mOUdzdQhiO5gmVU0hsI9Od\nyKhFMLwK1yjpvVRy2BZNk/V+OQUz2QgilNtswx0/gYpqDaxYknhQB3ipqxmzpgRT\nWmsYRAK1AgMBAAECggEAPAfZ5rvIXFNWt9OosItKrgxL0BPKmybunjL2nDWuDWzR\ne0YiIV02kLXcEWn/s+/okFy4bGF3a+mGt2FTBWYqcqPw8bw8+vEYHa7Una5CZguE\ny9PU/+dD3ipDMI8RMpyBf46AcT1kuwPaLUXLzCveqvdJOxSBTkczuGniB9lbQNpF\nzhFzdwxTqtewa3DD3SildeyBX8qrIuXxLVdr7wcsHW13pSDJGXMxOcypvARAPyTX\nzgqeAGvP+ZbPjEUrzj6zR8T3Cbmvxf+86lBYTqIqqOcT3QvMlnr4OPyxSZ/wMAgF\nNDxcy1F15gC/rL2jFVRcJfiTqwq+B9ZlvBAAdJFN7QKBgQDqLeGJFDmFS0N1I5j2\nmGHsaN6PqAveDFF1Uc2KyX1mNLZvW74/yZ4u4wwlxpGuV4ePsdZTj4O3BDTBAFco\nuAjvligP1gVzBQixJ9Z9tgB3BTwFxIf3AeC5IA/RxNZu1YtvB1yHFhtSrYHfFmTW\nXqEIlY9MjFFYlJb6i/b2Ir16HwKBgQDntng50OZUPhAlJsF0Y+KLDIkG324JJN/v\nKHTXKHR6QbQxSzdwVJio8pWcy5fi1yIIx6ddkMi+89muNgBwtXTxU6hvP6jXrs4w\nLvP9+AubAKT17qoRNQDQ2twW8rP6iu6tAVLvOynrUh4LYkLmIK4DRkXHrxa8fi3C\netSr1L6QqwKBgB9jJueInm0POWtp6gajRfy50ZrPm0eXvxNKc5I2j2gziIBEe6tx\nCpKeO/KUOtJzSOgpneB1S+Ir3iZANW5vvELgjV4SAYj5E8Eq5cTTsBxDx1e+j7q7\ntbMaaQRkrZkNZjLreatheygJuW59Qea5qDvOT/aimASXZeUO/XrgDSVhAoGAMj6T\n9V2CBHRsxdGQk29xWVt/fxkF4D+5uz9Xjqw8DaKfsyyvOdFuRPxNSvGu3sZtn9/D\nP/u8PAPeiPM2xznhwM62MGFqeFJ0bWhRCho2Ugcivh1hjVej9KXwoZ1BP6vOs38c\n/7khjuCAmVFWVlZxxU4ApZsm3/qwa4J9CUGZjP8CgYAa53A2lu6+8Tih8BVLezs5\nYIkge2JLdnqHSBCMIL4T8PJYfJKGsyp1RYhH4O2GFXbJF4jx9T0JbTzks/P189R6\ni8/7uefKZXxgc/EXDAGIE3fGWDxoJQzxz8XMaSMBjYM17z4Y0DbnSczuxtOeikX3\nvUpVz3pzxtQxIUA7qkuCWg==\n-----END PRIVATE KEY-----\n",
  "client_email": "margaritas@margaritas-393420.iam.gserviceaccount.com",
  "client_id": "107215078526357269310",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url":
      "https://www.googleapis.com/robot/v1/metadata/x509/margaritas%40margaritas-393420.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
};

// Las credenciales de Firebase (agrega tus propias credenciales)
const _firebaseCredentials = {
  // Agrega tus propias credenciales aquí
};

// ID de la hoja
const _hojadatos = "11OuKPQhH-Ag9m6aXwdwtJz0Bfo7DKJRIbUJawbkP7go";

class Product {
  String name;
  int quantity;
  int sellingPrice;
  int sellingFactory;
  String imageUrl;
  Product({
    required this.name,
    required this.quantity,
    required this.sellingPrice,
    required this.sellingFactory,
    required this.imageUrl,
  });
}

class INVENTARIO extends StatefulWidget {
  const INVENTARIO({Key? key}) : super(key: key);

  @override
  State<INVENTARIO> createState() => _INVENTARIOState();
}

class _INVENTARIOState extends State<INVENTARIO> {
  late TextEditingController controller;
  late TextEditingController cantidadController;
  late TextEditingController precioVentaController;
  late TextEditingController precioFabricaController;
  late TextEditingController imageUrlController;

  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    precioVentaController = TextEditingController();
    precioFabricaController = TextEditingController();
    cantidadController = TextEditingController();
    controller = TextEditingController();
    imageUrlController = TextEditingController();

    // Fetch existing product data from Google Sheets and update the products list
    fetchProductsFromGoogleSheets();
  }

  @override
  void dispose() {
    precioFabricaController.dispose();
    controller.dispose();
    precioVentaController.dispose();
    cantidadController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  // Fetch existing product data from Google Sheets and update the products list
  Future<void> fetchProductsFromGoogleSheets() async {
    try {
      // Replace _credenciales with your actual credentials
      final gsheets = GSheets(_credenciales);
      final ss = await gsheets.spreadsheet(_hojadatos);
      var sheet = ss.worksheetByTitle("inventario");

      // Fetch all rows from the "inventario" worksheet
      final currentData = await sheet?.values.allRows();

      if (currentData != null) {
        // Skip the first row (headers) and process the rest of the data
        final productsData = currentData.skip(0).map((row) {
          return Product(
              name: row[0],
              quantity: int.parse(row[1]),
              sellingPrice: int.parse(row[2]),
              imageUrl: row[3],
              sellingFactory: int.parse(row[4]));
        }).toList();

        setState(() {
          products = productsData;
        });
      }
    } catch (e) {
      // Handle any potential exceptions during the fetching process
      print("Error fetching data: $e");
    }
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
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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

          final product = Product(
            name: data['name']!,
            quantity: int.parse(data['cantidad']!),
            sellingPrice: int.parse(data['precioVenta']!),
            sellingFactory: int.parse(data['precioFabrica']!),
            imageUrl: data['imageUrl']!,
          );

          setState(() {
            products.add(product);
          });

          await _guardarProductoEnGoogleSheets(product);
        },
      ),
    );
  }

  Widget buildProductCard(Product product) {
    return Container(
      width: double.infinity,
      height: 320,
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
              child: Image.network(
                product.imageUrl, // Use the imageUrl to load the image
                width: double.infinity,
                height: 180,
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
                      "Inventario: ", // Add your own logic here
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
                      "Precio de mercado: ${product.sellingPrice}",
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
                      "Precio  de Fabrica: ${product.sellingFactory}",
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

  Future<void> _guardarProductoEnGoogleSheets(Product product) async {
    try {
      // Replace _credenciales with your actual credentials
      final gsheets = GSheets(_credenciales);
      final ss = await gsheets.spreadsheet(_hojadatos);
      var sheet = ss.worksheetByTitle("inventario");

      // Verificar si algún campo está vacío y asignar un valor predeterminado si es necesario
      final name = product.name.isEmpty
          ? "No se agregó información desde la aplicación"
          : product.name;
      final quantity = product.quantity <= 0 ? 0 : product.quantity;
      final sellingPrice = product.sellingPrice <= 0 ? 0 : product.sellingPrice;
      final sellingFactory =
          product.sellingFactory <= 0 ? 0 : product.sellingFactory;
      final imageUrl = product.imageUrl.isEmpty
          ? "No se agregó información desde la aplicación"
          : product.imageUrl;

      final row = [
        product.name,
        product.quantity.toString(),
        product.sellingPrice.toString(),
        product.sellingFactory.toString(),
        product.imageUrl,
      ];

      // Add the new product to the next available row (row numRows + 1)
      await sheet?.values.appendRow(row);
    } catch (e) {
      // Handle any potential exceptions during the saving process
      print("Error saving data: $e");
    }
  }

  Future<Map<String, dynamic>?> AgregarProducto() async {
    final gsheets = GSheets(_credenciales);
    final ss = await gsheets.spreadsheet(_hojadatos);
    var sheet = ss.worksheetByTitle("inventario");

    controller = TextEditingController();
    cantidadController = TextEditingController();
    precioVentaController = TextEditingController();
    precioFabricaController = TextEditingController();
    imageUrlController = TextEditingController(); // Initialize the controller

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
                labelStyle: TextStyle(fontSize: 15, color: Colors.black),
              ),
              controller: controller,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Cantidad',
                hintText: "Ingrese la cantidad",
                labelStyle: TextStyle(fontSize: 15, color: Colors.black),
              ),
              controller: cantidadController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Precio de Venta',
                hintText: "Ingrese el precio de venta",
                labelStyle: TextStyle(fontSize: 15, color: Colors.black),
              ),
              controller: precioVentaController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Precio de Fabrica',
                hintText: "Ingrese Precio de fabrica",
                labelStyle: TextStyle(fontSize: 15, color: Colors.black),
              ),
              controller: precioFabricaController,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'URL de la Imagen',
                hintText: "Ingrese la URL de la imagen",
                labelStyle: TextStyle(fontSize: 15, color: Colors.black),
              ),
              controller: imageUrlController,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Verificar si algún campo está vacío y asignar un valor predeterminado si es necesario
              final name = controller.text.isEmpty
                  ? "No se agregó información desde la aplicación"
                  : controller.text;
              final cantidad = cantidadController.text.isEmpty
                  ? "0"
                  : cantidadController.text;
              final precioVenta = precioVentaController.text.isEmpty
                  ? "0"
                  : precioVentaController.text;
              final precioFabrica = precioFabricaController.text.isEmpty
                  ? "0"
                  : precioFabricaController.text;
              final imageUrl = imageUrlController.text.isEmpty
                  ? "No se agregó información desde la aplicación"
                  : imageUrlController.text;

              Navigator.of(context).pop({
                'name': name,
                'cantidad': cantidad,
                'precioVenta': precioVenta,
                'precioFabrica': precioFabrica,
                'imageUrl': imageUrl, // Pass the image URL to the data
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

void main() {
  runApp(MaterialApp(
    home: INVENTARIO(),
  ));
}
