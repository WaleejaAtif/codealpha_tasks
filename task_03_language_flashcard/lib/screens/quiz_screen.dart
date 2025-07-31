// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flashcard_provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  final _controller = TextEditingController();

  void _checkAnswer(String userAnswer, String correctAnswer) {
    if (userAnswer.trim().toLowerCase() == correctAnswer.trim().toLowerCase()) {
      _score++;
    }
    setState(() {
      _currentIndex++;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashcards = Provider.of<FlashcardProvider>(context).flashcards;

    if (_currentIndex >= flashcards.length) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz Complete')),
        body: Center(child: Text('Your score: $_score / ${flashcards.length}')),
      );
    }

    final currentCard = flashcards[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Time')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Translate: ${currentCard.question}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Your Answer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () => _checkAnswer(_controller.text, currentCard.answer),
            )
          ],
        ),
      ),
    );
  }
}
