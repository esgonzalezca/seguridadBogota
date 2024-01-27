import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:startertemplate/pages/map_static.dart';

class MyCard extends StatelessWidget {
  final String hora;
  final String lugar;
  final String descripcion;
  final double latitud;
  final double longitud;

  MyCard(
      {required this.hora,
      required this.lugar,
      required this.descripcion,
      required this.latitud,
      required this.longitud});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hora: $hora'),
            SizedBox(height: 8.0),
            Text('Lugar: $lugar'),
            SizedBox(height: 8.0),
            Text('Descripción: $descripcion'),
          ],
        ),
      ),
    );
  }
}

class CardData {
  final String hora;
  final String lugar;
  final String descripcion;
  final double latitud;
  final double longitud;

  CardData(
      {required this.hora,
      required this.lugar,
      required this.descripcion,
      required this.latitud,
      required this.longitud});
}
