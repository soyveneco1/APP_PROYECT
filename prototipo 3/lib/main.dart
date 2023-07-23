import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gsheets/gsheets.dart';
import 'HomeScreen.dart';

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

void main() async {
  // iniciar Gsheets
  final gsheets = GSheets(_credenciales);
  // vincular spreadsheet con la base de datos
  final ss = await gsheets.spreadsheet(_hojadatos);
  // obtener la hoja dentro de la base de datos
  var sheet = ss.worksheetByTitle("inventario");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

/*
class PERSON extends StatefulWidget {
  const PERSON({super.key});

  @override
  State<PERSON> createState() => _PERSONState();
}

class _PERSONState extends State<PERSON> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class INVENTARIO extends StatefulWidget {
  const INVENTARIO({super.key});

  @override
  _INVENTARIOState createState() => _INVENTARIOState();
}

class _INVENTARIOState extends State<INVENTARIO> {
  List<Producto> inventario = [];

  void mostrarFormularioAgregarProducto() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar nuevo producto'),
          content: AgregarProductoForm(
            onGuardar: (nuevoProducto) {
              agregarProducto(nuevoProducto);
            },
          ),
        );
      },
    );
  }

  void agregarProducto(Producto producto) {
    setState(() {
      inventario.add(producto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  actions: [
        //  IconButton(
        //      color: Colors.white,
        //      onPressed: mostrarFormularioAgregarProducto,
        //       icon: Icon(Icons.add)),
        // ],
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
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: inventario.length,
        itemBuilder: (context, index) {
          Producto producto = inventario[index];
          return ListTile(
            leading: Image.network(producto.imagen),
            title: Text(producto.referencia),
            subtitle: Text("\$${producto.precio.toStringAsFixed(2)}"),
          );
        },
      ),
    );
  }
}

class AgregarProductoForm extends StatefulWidget {
  final Function(Producto) onGuardar;

  AgregarProductoForm({required this.onGuardar});

  @override
  _AgregarProductoFormState createState() => _AgregarProductoFormState();
}

class _AgregarProductoFormState extends State<AgregarProductoForm> {
  final _formKey = GlobalKey<FormState>();
  String referencia = '';
  String imagenURL = '';
  double precio = 0;

  void _guardarProducto() {
    if (_formKey.currentState!.validate()) {
      Producto nuevoProducto = Producto(
        referencia: referencia,
        imagen: imagenURL,
        precio: precio,
      );

      widget.onGuardar(nuevoProducto);
      Navigator.pop(
          context); // Cerrar el formulario después de agregar el producto.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Referencia'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingresa la referencia';
              }
              return null;
            },
            onSaved: (value) => referencia = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'URL de la imagen'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingresa la URL de la imagen';
              }
              return null;
            },
            onSaved: (value) => imagenURL = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Precio'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingresa el precio';
              }
              if (double.tryParse(value) == null) {
                return 'Por favor, ingresa un número válido';
              }
              return null;
            },
            onSaved: (value) => precio = double.parse(value!),
          ),
          ElevatedButton(
            onPressed: _guardarProducto,
            child: Text('Guardar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
        ],
      ),
    );
  }
}

class Producto {
  final String referencia;
  final String imagen;
  final double precio;

  Producto(
      {required this.referencia, required this.imagen, required this.precio});
}
*/