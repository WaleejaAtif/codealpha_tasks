import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:language_flashcard_app/main.dart'; // This should match your project name in pubspec.yaml

void main() {
  testWidgets('Home screen loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const FlashcardApp());

    expect(find.text('Language Flashcards'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
