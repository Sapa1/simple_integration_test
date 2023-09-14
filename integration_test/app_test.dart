import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_annotations/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized(); // Garante que todo o ambiente esteja carregado

  group('Home Page E2E test', () {
    // Cria o grupo de testes
    testWidgets(
        // Vai abrir o emulador para simular um usuario
        'Click 5x on increment fab',
        // Usando o WidgetTester, recebemos a instância do tester para programarmos nossos testes ( importante ser assincrono )
        (WidgetTester tester) async {
      app.main(); // Acessa a instancia do app e executa o main para rodar no emulador

      await tester.pumpAndSettle(); // Aguarda que todos os frames sejam executados

      for (var i = 0; i < 5; i++) {
        await tester.tap(find.byIcon(Icons.add));
        await Future.delayed(const Duration(seconds: 1));
      }

      await tester.pumpAndSettle();

      expect(find.text('5'), findsOneWidget);
    });
  });
  testWidgets(
    'Escreva no campo de texto para alterar o título da página',
    (tester) async {
      app.main();
      await tester.pumpAndSettle();

      var title = find.byKey(const Key('titleOutput')).evaluate().single.widget
          as Text; // Pega o titulo inicial especificando pela key

      expect(title.data, equals('Home')); // Acessa o texto mostrado na tela e compara com o valor esperado

      await tester.enterText(find.byKey(const Key('titleInput')), 'New title'); // Simula uma entrada de dado
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      title = find.byKey(const Key('titleOutput')).evaluate().single.widget as Text; // Pega novamente o titulo
      expect(title.data, equals('New title')); // Verifica se o valor está como esperado
    },
  );
}
