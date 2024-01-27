import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:startertemplate/pages/map_sample.dart';

/*

H O M E P A G E

This is the HomePage, the first page the user will see based off what was configured in the MainPage.
Currently it is just showing a vertical list of boxes.

What should the HomePage for your app look like?

You should place the most important aspect of your app on this page
as this is the very first page the user will see!

*/

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MyForm(),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  final TextEditingController textController3 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double latitud = 0;
  double longitud = 0;
  String place = "Agregue el lugar ";
  void _showMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> addDenuncia() {
    CollectionReference denuncias =
        FirebaseFirestore.instance.collection('denuncias');

    return denuncias.add({
      'hora': textController1.text,
      'latitud': latitud,
      'longitud': longitud,
      'descripcion': textController3.text,
      'usuario': FirebaseAuth.instance.currentUser?.uid,
    }).then((value) {
      print("Denuncia agregada exitosamente!");
      _showMessage(context, "Denuncia agregada exitosamente!");
      _resetForm();
    }).catchError((error) {
      print("Error al agregar la denuncia: $error");
      _showMessage(context, "Error al agregar la denuncia: $error");
    });
  }

  void _resetForm() {
    setState(() {
      place = "Agregar lugar";
      textController1.clear();
      textController2.clear();
      textController3.clear();
    });
  }

  void _openMapScreen() async {
    print("nos fuimos");
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              MapDynamic()), // Reemplaza MapScreen con el nombre correcto de tu pantalla del mapa
    );

    if (result != null && result is LatLng) {
      // Si result contiene las coordenadas (LatLng), actualiza el campo "Lugar"
      setState(() {
        place = 'Lat: ${result.latitude}, Lng: ${result.longitude}';
        latitud = result.latitude;
        longitud = result.longitude;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(title: 'Hora', controller: textController1),
              GestureDetector(
                onTap: () {
                  // Cuando se selecciona el campo "Lugar", abre la pantalla del mapa
                  _openMapScreen();
                },
                child: Container(
                  width: double.infinity, // Ocupa toda la pantalla horizontal
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lugar',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        child: Text(
                          place,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MyTextField(title: 'Descripción', controller: textController3),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addDenuncia();
                  }
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  MyTextField({required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
