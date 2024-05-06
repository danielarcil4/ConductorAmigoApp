import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class LocalizacionPage extends StatefulWidget {
  const LocalizacionPage({super.key});

  @override
  State<LocalizacionPage> createState() => _LocalizacionPageState();
}

class _LocalizacionPageState extends State<LocalizacionPage> {
  TextEditingController controller = TextEditingController();
  static const LatLng _posicionInicial =
      LatLng(6.214480275407333, -75.59531590496778);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: placesAutoCompleteTextField(),
          actions: [
            IconButton(
                onPressed: nothing(),
                icon: const Icon(Icons.check),
            )
          ],
        ),
        body: const GoogleMap(
          initialCameraPosition:
              CameraPosition(target: _posicionInicial, zoom: 13),
        ));
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
        isLatLngRequired: false,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          print("placeDetails" + prediction.lat.toString());
        },

        itemClick: (Prediction prediction) {
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
        },
        seperatedBuilder: const Divider(),
        containerHorizontalPadding: 10,

        // OPTIONAL// If you want to customize list view item builder
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(
                  width: 7,
                ),
                Expanded(child: Text(prediction.description ?? ""))
              ],
            ),
          );
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    );
  }

  nothing() {

  }
}
