import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  MapScreen({
    required this.latitude,
    required this.longitude,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  late Marker _marker;
  late String _address = '';

  @override
  void initState() {
    super.initState();
    _initializeMarker();
  }

  void _initializeMarker() {
    _marker = Marker(
      markerId: MarkerId('marker_1'),
      position: LatLng(widget.latitude, widget.longitude),
      infoWindow: InfoWindow(
        title: 'Ubicación seleccionada',
        snippet: 'Cargando dirección...',
      ),
      onTap: () {
        _getAddress();
      },
    );
  }

  void _getAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(widget.latitude, widget.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      setState(() {
        _address = '${place.locality}, ${place.country}';
        _marker = _marker.copyWith(
          infoWindowParam: InfoWindow(
            title: 'Ubicación seleccionada',
            snippet: _address,
          ),
        );
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _getAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 10.0,
        ),
        markers: {_marker},
      ),
    );
  }
}
