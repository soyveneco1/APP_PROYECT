import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("Margaritas",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ))),
    );
  }
}


/*

// ... (código anterior)

class _inventarioState extends State<inventario> {
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
        // Aquí agregamos el producto con la imagen seleccionada a la lista de productos
        agregarProducto();
        // Mostrar el cuadro de diálogo al presionar el botón flotante
        showDialog(
          context: context,
          builder: (context) => SlideInUp(
            child: ProductoDialogWidget(),
            duration: Duration(milliseconds: 400),
          ),
        );
      });
    }
  }

  // Resto del código...


*/ 