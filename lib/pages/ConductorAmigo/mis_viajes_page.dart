import 'package:flutter/material.dart';
import '../../cards/viaje_programado.dart';

class MisViajesPage extends StatefulWidget {
  const MisViajesPage({super.key});

  @override
  State<MisViajesPage> createState() => _MisViajesPageState();
}

class _MisViajesPageState extends State<MisViajesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  void _performSearch(String searchText) {
    // You can implement your search logic here
    //print("Performing search for: $searchText");
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
            "Buscar en Mis Viajes",
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
              'Mis Viajes programados (1)',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w400,
                  fontSize: 27),
            ),
            SizedBox(height: 10),
            viajeProgramado(
              destino: 'Rionegro, Antioquia',
              cupos: 'Cupos para pasajeros 3/4',
              horaDeSalida: '24 feb,7:58 PM',
              recogida: '231',
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              indent: 100,
              thickness: 1.5,
              color: Colors.grey,
              endIndent: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action here
        },
        elevation: 8,
        backgroundColor: const Color(0xFF7DB006),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  nuevoViaje() {}
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Buscar en Mis Viajes';

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
