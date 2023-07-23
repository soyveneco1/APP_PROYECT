import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gsheets/gsheets.dart';
import 'Paginas/Homepage.dart';
import 'Paginas/Inventario.dart';

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
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int paginaactual = 0;
  List<Widget> paginas = [
    HOMEPAGE(),
    INVENTARIOPAGE(),
    INBOXPAGE(),
    FAVORITEPAGE()
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PROTOTIPO 1",
      home: Scaffold(
        body: paginas[paginaactual],
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
                backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade900,
                padding: EdgeInsets.all(8.0),
                gap: 8,
                onTabChange: (index) {
                  setState(() {
                    paginaactual = index;
                  });
                },
                tabs: const [
                  GButton(
                      icon: Icons.home,
                      text: "home",
                      textColor: Colors.white,
                      iconColor: Colors.white),
                  GButton(
                      icon: Icons.inventory,
                      text: "inventary",
                      textColor: Colors.white,
                      iconColor: Colors.white),
                  GButton(
                      icon: Icons.inbox,
                      text: "inbox",
                      textColor: Colors.white,
                      iconColor: Colors.white),
                  GButton(
                      icon: Icons.favorite_border_outlined,
                      text: "favorite",
                      textColor: Colors.white,
                      iconColor: Colors.white),
                ]),
          ),
        ),
      ),
    );
  }
}

class HOMEPAGE extends StatelessWidget {
  const HOMEPAGE({super.key});

  @override
  Widget build(BuildContext context) {
    return Homepage();
  }
}

class INVENTARIOPAGE extends StatelessWidget {
  const INVENTARIOPAGE({super.key});

  @override
  Widget build(BuildContext context) {
    return inventario();
  }
}

class INBOXPAGE extends StatelessWidget {
  const INBOXPAGE({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "INBOX PAGE",
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}

class FAVORITEPAGE extends StatelessWidget {
  const FAVORITEPAGE({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "FAVORITE PAGE",
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
// Resto del código de main.dart (HOMEPAGE, INBOXPAGE, FAVORITEPAGE) se mantiene igual.

