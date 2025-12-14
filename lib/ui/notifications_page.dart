import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 170, 159, 8),
        automaticallyImplyLeading: true,
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

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE0B2), Color(0xFFFFCC80)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: FirestoreService().streamNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // 🔑 FALLBACK: NOTIFICACIONES FALSAS
            final List<Map<String, dynamic>> notifs =
                (snapshot.hasData && snapshot.data!.isNotEmpty)
                    ? List<Map<String, dynamic>>.from(snapshot.data!)
                    : [
                        {
                          'titulo': 'Bienvenido a GymFit',
                          'mensaje':
                              'Gracias por unirte. Ya puedes ver tus rutinas.',
                          'fecha': DateTime.now()
                              .subtract(const Duration(minutes: 5)),
                        },
                        {
                          'titulo': 'Nueva rutina disponible',
                          'mensaje':
                              'Se agregó una rutina de fuerza para principiantes.',
                          'fecha': DateTime.now()
                              .subtract(const Duration(hours: 3)),
                        },
                        {
                          'titulo': 'Recordatorio',
                          'mensaje':
                              'No olvides entrenar hoy 💪',
                          'fecha': DateTime.now()
                              .subtract(const Duration(days: 1)),
                        },
                        {
                          'titulo': 'Actualización',
                          'mensaje':
                              'Mejoramos el rendimiento de la aplicación.',
                          'fecha': DateTime.now()
                              .subtract(const Duration(days: 2)),
                        },
                      ];

            // 🔽 Ordenar por fecha descendente
            notifs.sort((a, b) {
              final DateTime fechaA = a['fecha'];
              final DateTime fechaB = b['fecha'];
              return fechaB.compareTo(fechaA);
            });

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifs.length,
              itemBuilder: (context, index) {
                final notif = notifs[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.notifications,
                          size: 32,
                          color: Color.fromARGB(178, 155, 129, 13),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notif['titulo'] ?? 'Notificación',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notif['mensaje'] ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                (notif['fecha'] as DateTime)
                                    .toLocal()
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
