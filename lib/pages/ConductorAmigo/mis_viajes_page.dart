import 'package:flutter/material.dart';
import 'package:conductor_amigo/pages/usuarioAmigo/edit_page.dart';

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
              'Mis Viajes Programados',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w400,
                  fontSize: 30),
            ),
            viajesProgramadosCard(
              destino: 'Rionegro, Antioquia',
              cantPasajeros: 'Cupos para pasajeros 3/4',
              fechaYhora: '24 feb,7:58 PM',
            ),
          ],
        ),
      ),
    );
  }
}

class viajesProgramadosCard extends StatelessWidget {
  final String destino;
  final String fechaYhora;
  final String cantPasajeros;

  const viajesProgramadosCard({
    super.key,
    required this.destino,
    required this.fechaYhora,
    required this.cantPasajeros,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  size: 50,
                  color: Color(0xFF14612C),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destino,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        fechaYhora,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cantPasajeros,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => const EditPage()));
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 30,
                    ),
                )
              ],
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
