import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:startertemplate/pages/denuncias/MyCard.dart';
import 'package:startertemplate/pages/map_point.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<LatLng> points = [];
  int numberPoints = 0;
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
      numberPoints = snapshot.docs.length;
      snapshot.docs.forEach((doc) {
        // print(doc.get("descripcion"));

        LatLng point = new LatLng(doc.get("latitud"), doc.get("longitud"));

        CardData cardData = CardData(
            descripcion: doc.get("descripcion"),
            hora: doc.get("hora"),
            lugar: "hola",
            latitud: doc.get("latitud"),
            longitud: doc.get("longitud"));
        cardDataList.add(cardData);
        // points.add(point);
        print('${doc.id} => ${doc.data()}');
      });
    } catch (error) {
      print("Failed to fetch users: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blue,
      child: MapPoint(cardDataList: cardDataList),
    );
  }
}
