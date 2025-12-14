import 'dart:async';

class FirestoreService {

  // 🔔 NOTIFICACIONES FALSAS
  Stream<List<Map<String, dynamic>>> streamNotifications() {
    return Stream.value([
      {
        'titulo': 'Recordatorio',
        'mensaje': '¡No olvides tu rutina de cardio hoy!',
        'fecha': DateTime.now().subtract(const Duration(minutes: 10)),
      },
      {
        'titulo': 'GymFit',
        'mensaje': 'Nueva rutina disponible para tren superior 💪',
        'fecha': DateTime.now().subtract(const Duration(hours: 2)),
      },
    ]);
  }

  // 🏋️ RUTINAS FALSAS
  Stream<List<Map<String, dynamic>>> streamRoutines() {
    return Stream.value([
      {
        'nombre': 'Rutina de Pecho',
        'descripcion': 'Press banca, aperturas y fondos',
      },
      {
        'nombre': 'Rutina de Pierna',
        'descripcion': 'Sentadillas, prensa y desplantes',
      },
      {
        'nombre': 'Rutina de Cardio',
        'descripcion': '30 min caminadora + bici',
      },
    ]);
  }
}
