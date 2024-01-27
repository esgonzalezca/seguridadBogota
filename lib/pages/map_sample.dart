import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDynamic extends StatefulWidget {
  @override
  _MapDynamicState createState() => _MapDynamicState();
}

class _MapDynamicState extends State<MapDynamic> {
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
                getUserCurrentLocation();
              },
              onTap: (LatLng point) {
                _addMarker(point);
              },
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
      _markers.clear();
      _markers.add(Marker(
        //  icon: Icons.adb_rounded;
        markerId: MarkerId("2"),
        position: _selectedPoint!,
        infoWindow: InfoWindow(
          title: 'My Current Location',
        ),
      ));
    });
    //  return location ;
  }

  void _addMarker(LatLng point) {
    // Agrega un marcador en el punto seleccionado
    setState(() {
      _markers.clear();
      _selectedPoint = point;
      _markers.add(
        Marker(
          markerId: MarkerId('selected_point'),
          position: point,
          infoWindow: InfoWindow(title: 'Selected Point'),
        ),
      );
    });

    // Imprime las coordenadas del punto seleccionado en consola
    print(
        'Coordenadas del punto seleccionado: ${point.latitude}, ${point.longitude}');
  }
}

void main() {
  runApp(MaterialApp(
    home: MapDynamic(),
  ));
}
