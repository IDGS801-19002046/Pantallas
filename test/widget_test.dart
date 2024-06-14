import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/main.dart';
import 'package:login/registration_screen.dart';
import 'package:login/display_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Name Registration App', () {
    testWidgets('Initial load shows registration screen when no name is saved',
        (WidgetTester tester) async {
      // Clear SharedPreferences before the test
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(MyApp(initialScreen: RegistrationScreen()));

      // Verify that the registration screen is shown
      expect(find.byType(RegistrationScreen), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Guardar'), findsOneWidget);
    });

    testWidgets('Saving a name shows display screen',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(MyApp(initialScreen: RegistrationScreen()));

      // Enter a name and save it
      await tester.enterText(find.byType(TextField), 'John Doe');
      await tester.tap(find.text('Guardar'));
      await tester.pumpAndSettle();

      // Verify that the display screen is shown with the saved name
      expect(find.byType(DisplayScreen), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('Editing a name', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'name': 'John Doe'});

      await tester.pumpWidget(MyApp(initialScreen: DisplayScreen()));

      // Tap the edit button to go to the edit screen
      await tester.tap(find.text('Editar Nombre'));
      await tester.pumpAndSettle();

      // Verify that the edit screen is shown
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);

      // Change the name and save it
      await tester.enterText(find.byType(TextField), 'Jane Doe');
      await tester.tap(find.text('Guardar'));
      await tester.pumpAndSettle();

      // Verify that the display screen shows the updated name
      expect(find.byType(DisplayScreen), findsOneWidget);
      expect(find.text('Jane Doe'), findsOneWidget);
    });

    testWidgets('Deleting a name returns to registration screen',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'name': 'John Doe'});

      await tester.pumpWidget(MyApp(initialScreen: DisplayScreen()));

      // Tap the delete button
      await tester.tap(find.text('Eliminar Nombre'));
      await tester.pumpAndSettle();

      // Verify that the registration screen is shown again
      expect(find.byType(RegistrationScreen), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
