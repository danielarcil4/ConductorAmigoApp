import 'package:conductor_amigo/pages/busqueda/Localizacion_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../ConductorAmigo/conductor_amigo_page.dart';

class EditViajePage extends StatefulWidget {
  final String location;
  const EditViajePage({super.key, required this.location});

  @override
  State<EditViajePage> createState() => _EditViajePageState();
}

class _EditViajePageState extends State<EditViajePage> {
  final TextEditingController _searchLocationController = TextEditingController(text: "Universidad de Antioquia");
  final TextEditingController _horaController = TextEditingController();
  final TextEditingController _minutoController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _diaController = TextEditingController();
  final TextEditingController _mesController = TextEditingController();
  final TextEditingController _anioController = TextEditingController();
  final TextEditingController _searchPlaceController = TextEditingController();

  final RegExp _validateHora = RegExp(r'^([01]?[0-9]|2[0-4])$');
  final RegExp _validateMinuto = RegExp(r'^([0-5]?[0-9]|60)$');
  final RegExp _validateDia = RegExp(r'^(0?[1-9]|[12][0-9]|3[01])$');
  final RegExp _validateMes = RegExp(r'^(0?[1-9]|1[012])$');
  final RegExp _validateAnio = RegExp(r'^(2[4-9]|[3-9][0-9])$');

  String? dropdownValue;
  bool showAdditionalOptions = false;

  final _formKey = GlobalKey<FormState>();
  String errorTextEmail = '';
  bool isVisiblePassword = false;

  String? _universidadOption= 'destino';

  Widget _buildInputField(
      TextEditingController controller,
      String labelName , {
        bool isRecogida = false,
        bool isDestino = false,
        bool isValor = false,
        bool isDia = false,
        bool isMes = false,
        bool isAnio = false,
        bool isHora = false,
        bool isMinuto = false,
        bool isOnlyNumbers = false,
        errorText,
        bool readOnly = false,
      }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: isOnlyNumbers ? TextInputType.number : TextInputType.text,
      inputFormatters: isOnlyNumbers
          ? [FilteringTextInputFormatter.digitsOnly]
          : [FilteringTextInputFormatter.singleLineFormatter],
      decoration: InputDecoration(
        errorText: errorTextEmail == '' ? null : errorText,
        labelText: labelName,
        labelStyle: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w400),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1)),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey,
              width: 2), // Cambia el color de resaltado aquí
        ),
      ),
      validator: (value) {
        if (isRecogida) {
          if (value!.isEmpty) {
            return 'Por favor, ingresa un punto de recogida';
          }
          return null;
        } else if (isOnlyNumbers) {
          if (isValor) {
            if (value!.isEmpty) {
              return 'Por favor, ingresa el \n valor del viaje';
            }
          } else if (isHora) {
            if (value!.isEmpty) {
              return 'Por favor, ingresa una hora de salida';
            } else if (!_validateHora.hasMatch(value)) {
              return 'Por favor, ingresa una \n hora válida, en formato \n de 24 horas (HH:MM)';
            }
          } else if (isMinuto) {
            if (value!.isEmpty) {
              return 'Por favor, ingresa una minuto de salida';
            } else if (!_validateMinuto.hasMatch(value)) {
              return 'Por favor, ingresa un \n minuto valido, en formato \n de 24 horas (HH:MM)';
            }
          } else if (isDia) {
            if (value!.isEmpty) {
              return 'Por favor, ingresa un día de salida';
            } else if (!_validateDia.hasMatch(value)) {
              return 'Por favor, ingresa un \n dia valido';
            }
          } else if (isMes) {
            if (value!.isEmpty) {
              return 'Por favor, ingresa un mes de salida';
            } else if (!_validateMes.hasMatch(value)) {
              return 'Por favor, ingresa un \n mes valido';
            }
          } else if (isAnio) {
            if (value!.isEmpty) {
              return 'Por favor, ingresa un año de salida';
            } else if (!_validateAnio.hasMatch(value)) {
              return 'Por favor, ingresa un \n año valido';
            }
          }
        } else if (isDestino) {
          if (value!.isEmpty) {
            return 'Por favor, ingresa el punto de destino';
          }
          return null;
        }
        return null;
      },
    );
  }

  Widget _buildElevatedButton(
      int colorButton,
      String text,
      bool guardarCambios,
      bool eliminarMensaje,
      ) {
    return ElevatedButton(
      onPressed: () {
        if (guardarCambios) {
          if (_formKey.currentState!.validate()) {
            updateCambios();
          }
        } else if (eliminarMensaje) {
          _mensajeEliminar(context);
        } else {
          _mensajeCancelar(context);
        }
      },
      style: ElevatedButton.styleFrom(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

  void _mensajeEliminar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Construye el cuadro de diálogo personalizado
        return AlertDialog(
            title: const Text(
              '¿Estás segur@?',
              textAlign: TextAlign.center,
              style:
              TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w500),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Eliminarás permanentemente\n'
                      'tu viaje programado.\n'
                      'Recuerda que serás penalizado\n'
                      'si eliminas tu viaje a 2 horas o\n'
                      'menos antes de la hora de\n'
                      'salida',
                  style: TextStyle(
                      fontFamily: 'Ubuntu', fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Cerrar el cuadro de diálogo
                        // Agregar aquí la lógica para salir de la aplicación
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'REGRESAR',
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ConductorAmigoPage()));
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: const Text(
                        'ELIMINAR',
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w400,
                            color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.white);
      },
    );
  }

  void _mensajeCancelar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Construye el cuadro de diálogo personalizado
        return AlertDialog(
            title: const Text(
              'Ya casi está...\n'
                  '¿Estás segur@?',
              textAlign: TextAlign.center,
              style:
              TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w500),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verifica que los datos sean\n'
                      'correctos y que no se te olvide\n'
                      'nada.\n',
                  style: TextStyle(
                      fontFamily: 'Ubuntu', fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Cerrar el cuadro de diálogo
                        // Agregar aquí la lógica para salir de la aplicación
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'REGRESAR',
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ConductorAmigoPage()));
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: const Text(
                        'CANCELAR',
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w400,
                            color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.white);
      },
    );
  }

  void updateCambios() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Construye el cuadro de diálogo personalizado
        return AlertDialog(
            title: const Text(
              'Felicidades!!!',
              textAlign: TextAlign.center,
              style:
              TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w500),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Se ha creado tu viaje\n'
                      'exitosamente.\n'
                      'Revisa el estado de tu\n'
                      'publicación en tu\n'
                      'perfil de conductor.',
                  style: TextStyle(
                      fontFamily: 'Ubuntu', fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ConductorAmigoPage()));
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: const Text(
                        'ACEPTAR',
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w400,
                            color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Colors.white);
      },
    );
  }

  Widget _buildSearchLocationSection() {
    if (_universidadOption == 'destino') {
      return Column(
        children: [
          GooglePlaceAutoCompleteTextField(
            textEditingController: _searchPlaceController,
            googleAPIKey: "AIzaSyDL9HdVwqcIPxiOfY-R3mMnuOO61ojZKOI",
            inputDecoration: InputDecoration(
              hintText: widget.location,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            debounceTime: 400,
            countries: const ["col"],
            itemClick: (Prediction prediction) {
              _searchPlaceController.text = prediction.description ?? "";
            },
          ),
          const SizedBox(height: 10),
          _buildInputField(_searchLocationController, 'Lugar de destino',
              isDestino: true, readOnly: true),
        ],
      );
    }
    return Column(
      children: [
        _buildInputField(_searchLocationController, 'Lugar de origen',
            isDestino: true, readOnly: true),
        const SizedBox(height: 20),
        GooglePlaceAutoCompleteTextField(
          textEditingController: _searchPlaceController,
          googleAPIKey: "AIzaSyDL9HdVwqcIPxiOfY-R3mMnuOO61ojZKOI",
          inputDecoration: InputDecoration(
            hintText: widget.location,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          debounceTime: 400,
          countries: const ["col"],
          itemClick: (Prediction prediction) {
            _searchPlaceController.text = prediction.description ?? "";
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false, // Eliminar el botón de retroceso
      toolbarHeight: 80,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edita tu viaje',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w400,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 5), // Espacio entre el título y el subtítulo
          Text(
            'Cambia los detalles de tus viajes programados',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w300,
              fontSize: 16, // Tamaño de fuente más pequeño para el subtítulo
            ),
          ),
        ],
      ),
      centerTitle: false, // Desactiva el centrado del título
      backgroundColor: const Color(0xFF0D6E2E),
    ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Recuerda que los viajes deben tener como punto de origen o lugar de destino la Universidad de Antioquia:",
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Punto de Origen'),
                        value: 'origen',
                        groupValue: _universidadOption,
                        onChanged: (value) {
                          setState(() {
                            _universidadOption = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Lugar de Destino'),
                        value: 'destino',
                        groupValue: _universidadOption,
                        onChanged: (value) {
                          setState(() {
                            _universidadOption = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildSearchLocationSection(),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LocalizacionPage()),
                    );
                  },
                  icon: const Icon(Icons.location_on_sharp),
                  label: const Text("Buscar la ubicacion en mapa"),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 35,
                        ),
                        elevation: 16,
                        isExpanded: true,
                        itemHeight: 60,
                        style: const TextStyle(color: Colors.black),
                        items: <String>['1', '2', '3', '4'].map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Cupos',
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w500),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey, width: 1)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2), // Cambia el color de resaltado aquí
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Elija el número de \n pasajeros disponibles'; // Mensaje de er
                            // ror si no se selecciona ninguna opción
                          }
                          return null; // Retorna null si la validación es exitosa
                        },
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildInputField(_valorController, "Costo",
                          isOnlyNumbers: true, isValor: true),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                            'Fecha de salida',
                            textAlign: TextAlign.left,
                          )),
                      SizedBox(width: 10),
                      Expanded(
                          child: Text(
                            'Hora de Salida',
                            textAlign: TextAlign.right,
                          )),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: _buildInputField(_diaController, "DD",
                            isDia: true, isOnlyNumbers: true),
                      ),
                      const SizedBox(width: 10),
                      const Text('/'),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildInputField(_mesController, "MM",
                            isMes: true, isOnlyNumbers: true),
                      ),
                      const SizedBox(width: 10),
                      const Text('/'),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildInputField(_anioController, "AA",
                            isAnio: true, isOnlyNumbers: true),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: _buildInputField(_horaController, "HH",
                            isHora: true, isOnlyNumbers: true),
                      ),
                      const SizedBox(width: 10),
                      const Text(':'),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildInputField(_minutoController, "MM",
                            isMinuto: true, isOnlyNumbers: true),
                      ),
                    ]),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: _buildElevatedButton(
                          0xFF7DB006, "GUARDAR", true, false),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildElevatedButton(
                          0x809E9E9E, "CANCELAR", false, false),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildElevatedButton(0xFFC74A4D, "ELIMINAR VIAJE", false, true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/**/