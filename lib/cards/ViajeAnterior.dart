import 'package:flutter/material.dart';

class ViajeAnterior extends StatelessWidget {
  final String destino;
  final String nombreConductor;
  final String fechaYhora;
  final double tarifa;
  final String modeloAuto;
  final String placa;

  const ViajeAnterior({
    super.key,
    required this.destino,
    required this.nombreConductor,
    required this.fechaYhora,
    required this.tarifa,
    required this.modeloAuto,
    required this.placa,
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
                  Icons.account_circle,
                  size: 50,
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
                        nombreConductor,
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
              ],
            ),
            const SizedBox(height: 8),
            Text(
              fechaYhora,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${tarifa.toStringAsFixed(0)} COP - $modeloAuto, $placa',
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Aquí puedes agregar la lógica para aceptar la tarifa ofrecida
                    // o cualquier otra acción que desees realizar.
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF14612C),
                      alignment: Alignment.centerLeft),
                  icon: const Icon(
                    Icons.replay,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Contactar nuevamente',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Aquí puedes agregar la lógica para aceptar la tarifa ofrecida
                    // o cualquier otra acción que desees realizar.
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      alignment: Alignment.centerLeft),
                  icon: const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Calificar',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}