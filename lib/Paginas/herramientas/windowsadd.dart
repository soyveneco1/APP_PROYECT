import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../Inventario.dart';

// Crear credenciales
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

// ID de la hoja
const _hojadatos = "11OuKPQhH-Ag9m6aXwdwtJz0Bfo7DKJRIbUJawbkP7go";

class ProductoDialogWidget extends StatefulWidget {
  @override
  _ProductoDialogWidgetState createState() => _ProductoDialogWidgetState();
}

class _ProductoDialogWidgetState extends State<ProductoDialogWidget> {
  List<Producto> productos = [];
  final TextEditingController referenciaController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController precioVentaController = TextEditingController();
  final TextEditingController precioFabricaController = TextEditingController();
  File? _image;

  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Aquí agregamos el producto con la imagen seleccionada a la lista de productos
      agregarProducto();

      // Mostrar el cuadro de diálogo al presionar el botón flotante
      Navigator.of(context).pop();
    }
  }

  Future<void> agregarProducto() async {
    final referencia = referenciaController.text;
    final cantidad = int.tryParse(cantidadController.text) ?? 0;
    final precioVenta = double.tryParse(precioVentaController.text) ?? 0.0;
    final precioFabrica = double.tryParse(precioFabricaController.text) ?? 0.0;

    // Crea un nuevo Producto con la información ingresada y la imagen seleccionada
    final nuevoProducto = Producto(
      referencia: referencia,
      cantidad: cantidad,
      precioMercado: precioVenta,
      precioFabrica: precioFabrica,
      imagen: _image,
    );

    // Agrega el nuevo producto a la base de datos
    final db = InventarioDB(GSheets(_credenciales));
    await db.init();
    //await db.agregarProducto(nuevoProducto);

    // Actualiza el estado para mostrar los productos actualizados
    setState(() {
      productos.add(nuevoProducto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade300,
      title: Text('Agregar Producto'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextFields para ingresar la referencia, cantidad, precio de venta y precio de fabricación
            TextField(
              controller: referenciaController,
              decoration: InputDecoration(labelText: 'Referencia'),
            ),
            TextFormField(
              controller: cantidadController,
              decoration: InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ], // Acepta solo dígitos numéricos
            ),
            TextFormField(
              controller: precioVentaController,
              decoration: InputDecoration(labelText: 'Precio de Venta'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ], // Acepta solo dígitos numéricos
            ),
            TextFormField(
              controller: precioFabricaController,
              decoration: InputDecoration(labelText: 'Precio de Fabricación'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ], // Acepta solo dígitos numéricos
            ),
            // Widget para mostrar la imagen seleccionada
            _image != null
                ? Image.file(
                    _image!,
                    height: 100,
                    width: 100,
                  )
                : Container(),
            // Botón para seleccionar la imagen
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text('Seleccionar imagen'),
              style: ElevatedButton.styleFrom(primary: Colors.black),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.black),
          onPressed: () {
            // Aquí puedes realizar alguna acción cuando se presione el botón "Cancelar"
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.black),
          onPressed: () {
            agregarProducto();
            Navigator.of(context).pop();
          },
          child: Text(
            'Aceptar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class Producto {
  String referencia;
  int cantidad;
  double precioMercado;
  double precioFabrica;
  File? imagen;

  Producto({
    required this.referencia,
    required this.cantidad,
    required this.precioMercado,
    required this.precioFabrica,
    this.imagen,
  });
}
