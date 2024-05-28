import 'package:flutter/material.dart';

import '../pages/ConductorAmigo/edit_page.dart';

class viajeProgramado extends StatelessWidget {
  final String destino;
  final String recogida;
  final String horaDeSalida;
  final String cupos;

  const viajeProgramado({
    super.key,
    required this.destino,
    required this.recogida,
    required this.horaDeSalida,
    required this.cupos,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const SizedOverflowBox(
              size: Size(20, 30),
              child: Icon(
                Icons.calendar_month_outlined,
                color: Color(0xFF14612C),
                size: 50,
              ),
            ),
            SizedOverflowBox(
              size: const Size(20, 5),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Hace que el contenedor tenga forma circular
                  color: const Color(0xFF7DB006).withOpacity(0.3),
                ),
                height: 50,
                width: 50,
              ),
            ),
            const Text(
              "2",
              style: TextStyle(
                color: Color(0xFF14612C),
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const Text(
              "may",
              style: TextStyle(
                color: Color(0xFF14612C),
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destino,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.63),
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    horaDeSalida,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cupos,
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const EditViajePage(location: 'Buscar lugar')));
              },
              icon: const Icon(
                Icons.edit_square,
                size: 35,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ],
    );
  }
}
