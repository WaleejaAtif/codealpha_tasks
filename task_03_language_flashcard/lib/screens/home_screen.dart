// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flashcard_provider.dart';
import '../widgets/flashcard_widget.dart';
import 'add_edit_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final flashcards = Provider.of<FlashcardProvider>(context).flashcards;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Flashcards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.quiz),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const QuizScreen()),
            ),
          ),
        ],
      ),
      body: flashcards.isEmpty
          ? const Center(child: Text('No flashcards yet.'))
          : ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (ctx, i) => FlashcardWidget(card: flashcards[i]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEditScreen()),
        ),
      ),
    );
  }
}
