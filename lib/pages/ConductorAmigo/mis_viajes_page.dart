import 'package:flutter/material.dart';
import '../../cards/viaje_programado.dart';
import 'crear_viaje_page.dart';
import 'package:conductor_amigo/pages/chat/auth_service.dart'; // Asegúrate de importar correctamente

class MisViajesPage extends StatefulWidget {
  const MisViajesPage({super.key});

  @override
  State<MisViajesPage> createState() => _MisViajesPageState();
}

class _MisViajesPageState extends State<MisViajesPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  List<Map<String, dynamic>> _viajes = [];

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    try {
      List<Map<String, dynamic>> trips = await _authService.getTrips();
      setState(() {
        _viajes = trips;
      });
    } catch (e) {
      // Manejar el error de alguna manera
    }
  }

  void _performSearch(String searchText) {
    setState(() {
      _searchText = searchText;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _filteredViajes = _viajes
        .where((viaje) =>
        viaje['destino'].toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextButton.icon(
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(_viajes),
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
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              minimumSize: MaterialStateProperty.all(const Size(400, 40))),
        ),
        flexibleSpace: Container(
          color: const Color(0xFF7DB006),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Mis Viajes programados (${_filteredViajes.length})',
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w400,
                  fontSize: 27),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredViajes.length,
                itemBuilder: (context, index) {
                  final viaje = _filteredViajes[index];
                  return Column(
                    children: [
                      ViajeProgramadoCard(viaje: viaje),
                      const SizedBox(height: 10),
                      const Divider(
                        indent: 100,
                        thickness: 1.5,
                        color: Colors.grey,
                        endIndent: 10,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CrearViajePage(location: 'Buscar lugar')),
          ).then((_) => _loadTrips());  // Recargar los viajes al regresar de la página de creación
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
}

class ViajeProgramadoCard extends StatelessWidget {
  final Map<String, dynamic> viaje;

  const ViajeProgramadoCard({required this.viaje});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          viaje['destino'],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(viaje['cupos']),
        const SizedBox(height: 5),
        Text(viaje['horaDeSalida']),
        const SizedBox(height: 5),
        Text(viaje['recogida']),
        const SizedBox(height: 5),
        Text(viaje['destino']),
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> viajes;

  CustomSearchDelegate(this.viajes);

  @override
  String get searchFieldLabel => 'Buscar en Mis Viajes';

  @override
  List<Widget> buildActions(BuildContext context) {
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
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Map<String, dynamic>> _filteredViajes = viajes
        .where((viaje) =>
        viaje['destino'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: _filteredViajes.length,
      itemBuilder: (context, index) {
        final viaje = _filteredViajes[index];
        return ListTile(
          title: Text(viaje['destino']),
          subtitle: Text(viaje['cupos']),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Map<String, dynamic>> _filteredViajes = viajes
        .where((viaje) =>
        viaje['destino'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: _filteredViajes.length,
      itemBuilder: (context, index) {
        final viaje = _filteredViajes[index];
        return ListTile(
          title: Text(viaje['destino']),
          subtitle: Text(viaje['cupos']),
          onTap: () {
            query = viaje['destino'];
            showResults(context);
          },
        );
      },
    );
  }
}
