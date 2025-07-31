import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/flashcard_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FlashcardProvider(),
      child: MaterialApp(
        title: 'Flashcard Quiz App',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const HomeScreen(),
      ),
    );
  }
}
