import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:geocoding/geocoding.dart';

import '../ConductorAmigo/crear_viaje_page.dart';

class LocalizacionPage extends StatefulWidget {
  const LocalizacionPage({Key? key}) : super(key: key);

  @override
  State<LocalizacionPage> createState() => _LocalizacionPageState();
}

class _LocalizacionPageState extends State<LocalizacionPage> {
  TextEditingController controller = TextEditingController();
  static const LatLng _posicionInicial =
      LatLng(6.214480275407333, -75.59531590496778);
  late GoogleMapController mapController;
  Marker? selectedMarker;
  late String direccionSeleccionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: placesAutoCompleteTextField(),
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: _posicionInicial, zoom: 13),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: selectedMarker != null ? {selectedMarker!} : {},
        onTap: _handleTap, // Método llamado al hacer clic en el mapa
        zoomControlsEnabled: false,
      ),
    );
  }

  Widget placesAutoCompleteTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: GooglePlaceAutoCompleteTextField(
              textEditingController: controller,
              googleAPIKey: "AIzaSyDL9HdVwqcIPxiOfY-R3mMnuOO61ojZKOI",
              inputDecoration: const InputDecoration(
                hintText: "Busquemos la localización",
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              debounceTime: 400,
              countries: const ["col"],
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (Prediction prediction) {
                if (prediction.lat != null && prediction.lng != null) {
                  final lat = double.parse(prediction.lat!);
                  final lng = double.parse(prediction.lng!);
                  _updateMapLocation(lat,
                      lng); // Método llamado al obtener detalles de la predicción
                }
              },
              itemClick: (Prediction prediction) {
                controller.text = prediction.description ?? "";
                controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: prediction.description?.length ?? 0));
                if (prediction.lat != null && prediction.lng != null) {
                  final lat = double.parse(prediction.lat!);
                  final lng = double.parse(prediction.lng!);
                  _updateMapLocation(lat,
                      lng); // Método llamado al hacer clic en una predicción
                }
              },
              seperatedBuilder: const Divider(),
              containerHorizontalPadding: 10,
              itemBuilder: (context, index, Prediction prediction) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 7),
                      Expanded(child: Text(prediction.description ?? ""))
                    ],
                  ),
                );
              },
              isCrossBtnShown: true,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.check,
            color: Colors.green),
            onPressed: () {
              // Guardar la dirección seleccionada
              direccionSeleccionada = controller.text;
              // Navegar a otra página y pasar la dirección como argumento
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CrearViajePage()),
              );
            },
          ),
        ],
      ),
    );
  }

  // Método llamado al hacer clic en el mapa
  void _handleTap(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      setState(() {
        controller.text =
            "${place.street}, ${place.locality}, ${place.country}";
        selectedMarker = Marker(
          markerId: const MarkerId('selectedLocation'),
          position: latLng,
        );
        mapController.animateCamera(CameraUpdate.newLatLng(latLng));
      });
    }
  }

  // Método para actualizar la ubicación en el mapa y el marcador
  void _updateMapLocation(double lat, double lng) {
    final position = LatLng(lat, lng);
    setState(() {
      selectedMarker = Marker(
        markerId: const MarkerId('selectedLocation'),
        position: position,
      );
    });
    mapController.animateCamera(CameraUpdate.newLatLng(position));
  }
}
