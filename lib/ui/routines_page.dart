import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class RoutinesPage extends StatelessWidget {
  const RoutinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutinas'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 170, 159, 8),

        // 🔙 SIEMPRE volver a HOME
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          },
        ),
      ),

      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: FirestoreService().streamRoutines(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 🔑 FALLBACK: si Firestore no devuelve nada, usamos datos falsos
          final routines =
              (snapshot.hasData && snapshot.data!.isNotEmpty)
                  ? snapshot.data!
                  : [
                      {
                        'titulo': 'Rutina de Pierna',
                        'descripcion':
                            'Sentadillas, prensa, desplantes y extensión de pierna',
                      },
                      {
                        'titulo': 'Rutina de Pecho',
                        'descripcion':
                            'Press banca, aperturas con mancuernas y fondos',
                      },
                      {
                        'titulo': 'Rutina de Espalda',
                        'descripcion':
                            'Jalones, remo con barra y peso muerto',
                      },
                      {
                        'titulo': 'Rutina de Cardio',
                        'descripcion':
                            '30 minutos caminadora + 15 minutos bicicleta',
                      },
                    ];

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: routines.length,
            itemBuilder: (context, index) {
              final routine = routines[index];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        routine['titulo'] ?? 'Rutina',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        routine['descripcion'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
