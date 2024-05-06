import 'package:flutter/material.dart';

import '../../cards/viaje_anterior.dart';

class ViajesAnterioresPage extends StatefulWidget {
  const ViajesAnterioresPage({super.key});

  @override
  State<ViajesAnterioresPage> createState() => _ViajesAnterioresPageState();
}

class _ViajesAnterioresPageState extends State<ViajesAnterioresPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  void _performSearch(String searchText) {
    // You can implement your search logic here
    //print("Performing search for: $searchText");
    // For demonstration, I'm just printing the search text
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextButton.icon(
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
          icon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          label: const Text(
            "¿A dónde vamos?",
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w400,
            ),
          ),
          style: ButtonStyle(
              alignment: Alignment.centerLeft,
              backgroundColor: MaterialStateProperty.all(Colors.white),
              // Color del fondo
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Cambiar el radio del borde
                ),
              ),
              minimumSize: MaterialStateProperty.all(const Size(400, 40))),
        ), //

        flexibleSpace: Container(
          color: const Color(0xFF7DB006),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tus viajes anteriores',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w400,
                  fontSize: 30),
            ),
            ViajeAnterior(
              destino: 'Rionegro, Antioquia',
              nombreConductor: 'Conductor 1',
              fechaYhora: '24 feb,7:58 PM',
              tarifa: 25000,
              // Precio ofrecido por el conductor
              modeloAuto: 'Renault',
              placa: 'LKM325',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => '¿A dónde vamos?';

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones para el AppBar (icono de limpieza, etc.)
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar (generalmente el botón de atrás)
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Muestra los resultados basados en la búsqueda actual
    return Center(
      child: Text('Results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Muestra sugerencias mientras se escribe la búsqueda
    return Center(
      child: Text('Suggestions for: $query'),
    );
  }
}

