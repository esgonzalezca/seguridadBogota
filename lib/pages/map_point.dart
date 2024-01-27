import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:startertemplate/pages/denuncias/MyCard.dart';

class MapPoint extends StatefulWidget {
  MapPoint({required this.cardDataList, Key? key}) : super(key: key);
  final List<CardData> cardDataList;
  int currentIdPoint = 0;
  int radiusInKm = 20;

  @override
  _MapPointState createState() => _MapPointState();
}

class _MapPointState extends State<MapPoint> {
  late GoogleMapController _controller;
  Set<Marker> _markers = {};
  LatLng? _selectedPoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400, // Tamaño fijo para la columna
      child: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.hybrid,
              onMapCreated: (controller) {
                _controller = controller;
                getUserCurrentLocationInit();
              },
              onTap: (LatLng point) {},
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(0.0, 0.0),
                zoom: 15.0,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              getUserCurrentLocation();
            },
            child: Icon(Icons.my_location),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _selectedPoint);
            },
            child: Text('Seleccionar'),
          ),
        ],
      ),
    );
  }

  void getUserCurrentLocationInit() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });

    Position position = await Geolocator.getCurrentPosition();
    _selectedPoint = LatLng(position.latitude, position.longitude);

    setState(() {
      _controller.animateCamera(CameraUpdate.newLatLng(_selectedPoint!));
      _markers.clear();
      _markers.add(Marker(
        //  icon: Icons.adb_rounded;
        markerId: MarkerId(widget.currentIdPoint.toString()),
        position: _selectedPoint!,
        infoWindow: InfoWindow(
          title: 'My Current Location',
        ),
      ));
      print("agregamos el primero");
      for (CardData card in widget.cardDataList) {
        widget.currentIdPoint++;
        LatLng point = LatLng(card.latitud, card.longitud);
        double distance = calculateHaversineDistance(_selectedPoint!, point);

        if (distance <= widget.radiusInKm) {
          print("vamos a agregar");
          _markers.add(Marker(
            //  icon: Icons.adb_rounded;
            markerId: MarkerId(widget.currentIdPoint.toString()),
            position: point!,
            onTap: () {
              _showInfoWindow(card);
            },
            /*infoWindow: InfoWindow(
              title: card.descripcion + " \n " + card.hora,
            ),*/
          ));
        }
      }
    });
    //  return location ;
  }

  void _showInfoWindow(CardData info) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Text(
            info.descripcion + "\n a las " + info.hora,
            style: TextStyle(fontSize: 18.0),
          ),
        );
      },
    );
  }

  double calculateHaversineDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371.0; // Radio de la Tierra en kilómetros

    double dLat = radians(point2.latitude - point1.latitude);
    double dLon = radians(point2.longitude - point1.longitude);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(radians(point1.latitude)) *
            cos(radians(point2.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;

    return distance;
  }

  double radians(double degrees) {
    return degrees * pi / 180;
  }

  void getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });

    Position position = await Geolocator.getCurrentPosition();
    _selectedPoint = LatLng(position.latitude, position.longitude);

    setState(() {
      _controller.animateCamera(CameraUpdate.newLatLng(_selectedPoint!));
    });
    //  return location ;
  }
}
