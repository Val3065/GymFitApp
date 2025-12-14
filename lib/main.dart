// lib/main.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app_router.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };

  runZonedGuarded(() async {
    try {
      // Inicializar Firebase en TODAS las plataformas
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      runApp(const GymFitApp());
    } catch (e, st) {
      runApp(ErrorApp(error: e, stack: st));
    }
  }, (error, stack) {
    // Errores no manejados silenciosos
  });
}

class GymFitApp extends StatelessWidget {
  const GymFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymFitApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3A86FF)),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}

class ErrorApp extends StatelessWidget {
  final Object error;
  final StackTrace stack;
  const ErrorApp({super.key, required this.error, required this.stack});

  @override
  Widget build(BuildContext context) {
    final errorText = error.toString();
    final stackText = stack.toString();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Error de inicialización')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ocurrió un error inicializando Firebase:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              SelectableText(errorText, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              const Text('Stacktrace:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SelectableText(stackText),
            ],
          ),
        ),
      ),
    );
  }
}