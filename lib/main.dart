import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
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
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text("Margaritas",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              )),
        ),
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
    return Center(
      child: Text(
        "HOME PAGE",
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}

class INVENTARIOPAGE extends StatelessWidget {
  const INVENTARIOPAGE({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "INVENTARIO PAGE",
        style: TextStyle(fontSize: 25),
      ),
    );
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
