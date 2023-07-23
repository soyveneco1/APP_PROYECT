import 'package:flutter/material.dart';

class INVENTARIO extends StatefulWidget {
  const INVENTARIO({super.key});

  @override
  State<INVENTARIO> createState() => _INVENTARIOState();
}

class _INVENTARIOState extends State<INVENTARIO> {
  late TextEditingController controller;
  String name = "";
  @override
  void initState() {
    // TODO: implement setState
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
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
      /////////////////////////////////////////

      body: Padding(
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
                      child: Image.asset(
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
                              name,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
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
                              "Precio de venta: ",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 17),
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
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 17),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),

      ////////////////////////////////////////
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: () async {
          final name = await AgregarProducto();
          if (name == null || name.isEmpty) return;
          setState(() {
            this.name = name;
          });
        },
      ),
    );
  }

  Future AgregarProducto() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Agregar Producto"),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: 'Referencia',
                  hintText: "Ingrese la referencia",
                  labelStyle: TextStyle(fontSize: 25, color: Colors.black)),
              controller: controller,
            ),
            actions: [
              TextButton(
                  onPressed: agregar,
                  child: Text(
                    "agregar",
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ));
  void agregar() {
    Navigator.of(context).pop(controller.text);
  }
}

//print("Item :$index")  body: ListView.builder(
   //                         itemBuilder: itemBuilder),