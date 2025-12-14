import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = AuthService();
  final _firestore = FirestoreService();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text('GymFitApp'),
  centerTitle: true,
  backgroundColor: const Color.fromARGB(181, 143, 106, 5),

  // 🔙 SIEMPRE vuelve al HOME
leading: (_selectedIndex == 1 || _selectedIndex == 2)
    ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            _selectedIndex = 0; // 🔙 vuelve SIEMPRE al Home
          });
        },
      )
    : null,

  actions: [
    IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () async {
        await _auth.signOut();
        if (!mounted) return;
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/login');
      },
    ),
  ],
),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE0B2), Color(0xFFFFCC80)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _buildPage(_selectedIndex),
      ),
    
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return _buildHome();
      case 1:
        return _buildRoutines();
      case 2:
        return _buildNotifications();
      default:
        return _buildHome();
    }
  }

  Widget _buildHome() {
  final user = _auth.currentUser;

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado centrado (similar a tu versión original)
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(255, 175, 115, 4),
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  'Bienvenido, ${user?.displayName ?? 'Usuario'}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF5C3710),
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  user?.email ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                      ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Card de membresía (mantiene la idea del Card original)
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 24),
                      SizedBox(width: 12),
                      Text(
                        'Membresía Activa',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Plan Premium',
                    style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: const Color.fromARGB(255, 168, 144, 4),
                            ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Acceso completo a todas las rutinas y notificaciones',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // --- Tarjeta grande estilo mockup ---
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFD19A5A), // color similar al boceto
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // fila superior: icono + texto del gimnasio
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 175, 115, 4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person,
                          size: 38, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'GymFit',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            user?.displayName ?? 'Usuario',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // simulación de código de barras (no requiere assets)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // barras simples generadas con un Row de containers finos
                      SizedBox(
                        height: 0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: List.generate(40, (i) {
                            // Alterna anchos para dar aspecto de código de barras
                            final w = (i % 3 == 0) ? 3.0 : 1.0;
                            final color = (i % 7 == 0) ? Colors.black : Colors.transparent;
                            return Container(
                              width: w,
                              color: color,
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '21123456789',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 36),

          // Botones grandes: Rutinas y Notificaciones (estilo parecido al boceto)
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              icon: const Icon(Icons.fitness_center),
              label: const Text('Rutinas'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color.fromARGB(186, 206, 193, 7),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(fontSize: 16),
                elevation: 4,
              ),
              onPressed: () => setState(() => _selectedIndex = 1),
            ),
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              icon: const Icon(Icons.notifications),
              label: const Text('Notificaciones'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color.fromARGB(186, 206, 193, 7),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(fontSize: 16),
                elevation: 4,
              ),
              onPressed: () => setState(() => _selectedIndex = 2),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}


  Widget _buildRoutines() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _firestore.streamRoutines(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No hay rutinas disponibles'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final routine = snapshot.data![index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.fitness_center,
                            color: Color.fromARGB(255, 99, 86, 15)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            routine['nombre'] ?? 'Rutina',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      routine['descripcion'] ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black54,
                          ),
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromARGB(186, 206, 193, 7),
                      ),
                      onPressed: () {},
                      child: const Text('Comenzar'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildNotifications() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _firestore.streamNotifications(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay notificaciones'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final notif = snapshot.data![index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.notifications,
                            color: Color.fromARGB(255, 138, 107, 4)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            notif['titulo'] ?? 'Notificación',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      notif['mensaje'] ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black54,
                          ),
                    ),
                    const SizedBox(height: 8),
                   Text(
  notif['fecha'] != null
      ? (notif['fecha'] as DateTime).toLocal().toString()
      : '',
  style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.grey,
      ),
),

                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
