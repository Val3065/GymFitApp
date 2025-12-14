import 'package:flutter_test/flutter_test.dart';
import 'package:gymfitapp/main.dart';

void main() {
  testWidgets('GymFitApp muestra pantalla de login', (WidgetTester tester) async {
    // Construye la app y dispara un frame.
    await tester.pumpWidget(const GymFitApp());

    // Verifica que aparece la pantalla de login.
    expect(find.text('Iniciar sesión'), findsOneWidget);
  });
}