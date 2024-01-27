import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:startertemplate/pages/denuncias/MyCard.dart';
import 'package:startertemplate/pages/map_static.dart';

/*

S H O P P A G E

This is the ShopPage.
Currently it is just showing a grid of boxes.

This page should be populated with products and services 
that the user can buy $

*/

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Tarjetas'),
        ),
        body: Center(
          child: MyCardList(),
        ),
      ),
    );
  }
}

class MyCardList extends StatefulWidget {
  @override
  _MyCardListState createState() => _MyCardListState();
}

class _MyCardListState extends State<MyCardList> {
  int listLength = 0;
  final List<CardData> cardDataList = [
    // Agrega más datos según sea necesario
  ];

  @override
  void initState() {
    super.initState();
    fetchDenuncias().then((_) {
      // setState para reconstruir el widget después de que la función se complete
      setState(() {
        // Puedes hacer cualquier cosa aquí después de que la función se complete
      });
    });
  }

  Future<void> fetchDenuncias() async {
    CollectionReference denuncias =
        FirebaseFirestore.instance.collection('denuncias');

    try {
      QuerySnapshot snapshot = await denuncias.get();
      print(snapshot.docs.length);
      listLength = snapshot.docs.length;
      snapshot.docs.forEach((doc) {
        // print(doc.get("descripcion"));
        CardData cardData = CardData(
            descripcion: doc.get("descripcion"),
            hora: doc.get("hora"),
            lugar: "hola",
            latitud: doc.get("latitud"),
            longitud: doc.get("longitud"));
        cardDataList.add(cardData);

        print('${doc.id} => ${doc.data()}');
      });
    } catch (error) {
      print("Failed to fetch users: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listLength,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _mostrarDetalles(context, cardDataList[index]),
          child: MyCard(
              hora: cardDataList[index].hora,
              lugar: cardDataList[index].latitud.toString() +
                  cardDataList[index].longitud.toString(),
              descripcion: cardDataList[index].descripcion,
              latitud: cardDataList[index].latitud,
              longitud: cardDataList[index].longitud),
        );
      },
    );
  }

  void _mostrarDetalles(BuildContext context, CardData cardData) {
    print("la card data latitud es :" + cardData.latitud.toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Hora: ${cardData.hora}'),
              SizedBox(height: 8.0),
              Text('Lugar: ${cardData.lugar}'),
              SizedBox(height: 8.0),
              Text('Descripción: ${cardData.descripcion}'),
              MapStatic(point: new LatLng(cardData.latitud, cardData.longitud))
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
}
