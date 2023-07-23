import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gsheets/gsheets.dart';

import 'herramientas/windowsadd.dart';

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

class inventario extends StatefulWidget {
  const inventario({super.key});

  @override
  State<inventario> createState() => _inventarioState();
}

class _inventarioState extends State<inventario> {
  //////////////////////////////////////
  List<Producto> productos = [];

  @override
  void initState() {
    super.initState();
    cargarProductos();
  }

  Future<void> cargarProductos() async {
    final db = InventarioDB(GSheets(_credenciales));
    await db.init();
    final productosBD = await db.obtenerProductos();
    if (mounted) {
      setState(() {
        productos = productosBD;
      });
    }
    setState(() {
      productos = productosBD;
    });
  }

  ////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Inventario",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon((Icons.add)),
          onPressed: () {
            // Mostrar el cuadro de diálogo al presionar el botón flotante
            showDialog(
              context: context,
              builder: (context) => SlideInUp(
                child: ProductoDialogWidget(),
                duration: Duration(milliseconds: 400),
              ),
            );
          }),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 290,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: productos[index].imagen != null
                              ? Image.file(
                                  productos[index].imagen!,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : Container(), // Si no hay imagen, no se muestra nada
                        ),
                        Row(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  "Referencia: ${productos[index].referencia}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
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
                                  "Precio de venta: ${productos[index].precioMercado}",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                  ),
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
                                  "Inventario: ${productos[index].cantidad}",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class InventarioDB {
  final GSheets _gsheets;
  Worksheet? _sheet;

  InventarioDB(this._gsheets);

  Future<void> init() async {
    // Vincular el spreadsheet con la base de datos
    final ss = await _gsheets.spreadsheet(_hojadatos);
    // Obtener la hoja dentro de la base de datos
    _sheet = ss.worksheetByTitle("inventario");
  }

  Future<void> agregarProducto(Producto producto) async {
    // Guardar los datos del producto en la base de datos
    await _sheet!.values.appendRow([
      producto.referencia,
      producto.cantidad.toString(),
      producto.precioMercado.toString(),
      producto.precioFabrica.toString(),
      producto.imagen?.path ?? '',
    ]);
  }

  Future<List<Producto>> obtenerProductos() async {
    final rows = await _sheet!.values.allRows();
    List<Producto> productos = [];

    // Convertir los datos obtenidos desde la base de datos en objetos Producto
    for (var row in rows) {
      productos.add(Producto(
        referencia: row[0],
        cantidad: int.parse(row[1]),
        precioMercado: double.parse(row[2]),
        precioFabrica: double.parse(row[3]),
        imagen: row[4].isNotEmpty ? File(row[4]) : null,
      ));
    }

    return productos;
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
