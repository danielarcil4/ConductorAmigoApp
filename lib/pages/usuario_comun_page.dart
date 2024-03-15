import 'package:flutter/material.dart' hide SearchBar;

class UsuarioComunPage extends StatefulWidget {
  const UsuarioComunPage({super.key});

  @override
  State<UsuarioComunPage> createState() => _UsuarioComunPageState();
}

class _UsuarioComunPageState extends State<UsuarioComunPage> {
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
            minimumSize:  MaterialStateProperty.all(const Size(400,45))
          ),
        ),//

        flexibleSpace: Container(
          color: const Color(0xFF7DB006),
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

Widget _buildInputField(TextEditingController controller, String labelName) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.edit,
          size: 20,
        ),
        labelText: labelName,
        labelStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w400),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1))),
  );
}

Widget _buildElevatedButton(int colorButton, String text) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Color(colorButton),
        elevation: 20,
        shadowColor: const Color(0xFF14612C),
        minimumSize: const Size.fromHeight(50)),
    child: Text(
      text,
      style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w300),
    ),
  );
}
