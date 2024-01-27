import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapStatic extends StatefulWidget {
  MapStatic({required this.point, Key? key}) : super(key: key);

  final LatLng point;

  @override
  _MapStaticState createState() => _MapStaticState();
}

class _MapStaticState extends State<MapStatic> {
  late GoogleMapController _controller;
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Tamaño fijo para la columna
      child: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.hybrid,
              onMapCreated: (controller) {
                _controller = controller;
                getPointLocation();
              },
              onTap: (LatLng point) {},
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(0.0, 0.0),
                zoom: 15.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getPointLocation() async {
    setState(() {
      _controller.animateCamera(CameraUpdate.newLatLng(widget.point));
      _markers.clear();
      _markers.add(Marker(
        //  icon: Icons.adb_rounded;
        markerId: MarkerId("2"),
        position: widget.point,
        infoWindow: InfoWindow(
          title: 'My Current Location',
        ),
      ));
    });
    //  return location ;
  }
}
