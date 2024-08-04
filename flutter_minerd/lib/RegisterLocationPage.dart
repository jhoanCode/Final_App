import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class RegisterLocationPage extends StatefulWidget {
  @override
  _RegisterLocationPageState createState() => _RegisterLocationPageState();
}

class _RegisterLocationPageState extends State<RegisterLocationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  late GoogleMapController mapController;
  Marker? _marker;
  String _address = '';

  void _getAddress(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      setState(() {
        _address = '${place.locality}, ${place.country}';
        _marker = Marker(
          markerId: MarkerId('marker_1'),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: 'Ubicación seleccionada',
            snippet: _address,
          ),
        );
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Ubicación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: latitudeController,
                decoration: InputDecoration(labelText: 'Latitud'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce la latitud';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: longitudeController,
                decoration: InputDecoration(labelText: 'Longitud'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce la longitud';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    double latitude = double.parse(latitudeController.text);
                    double longitude = double.parse(longitudeController.text);
                    _getAddress(latitude, longitude);
                    mapController.animateCamera(CameraUpdate.newLatLng(LatLng(latitude, longitude)));
                  }
                },
                child: Text('Mostrar en Mapa'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 2.0,
                  ),
                  markers: _marker != null ? {_marker!} : {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
