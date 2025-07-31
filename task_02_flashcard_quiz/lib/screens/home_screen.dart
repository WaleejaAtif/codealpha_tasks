import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard.dart';
import '../providers/flashcard_provider.dart';
import '../widgets/flashcard_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _showAnswer = false;
  String? feedback;

  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  void _showFlashcardDialog({Flashcard? existing, int? index}) {
    if (existing != null) {
      _questionController.text = existing.question;
      _answerController.text = existing.answer;
    } else {
      _questionController.clear();
      _answerController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(existing == null ? 'Add Flashcard' : 'Edit Flashcard'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(labelText: 'Answer'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newCard = Flashcard(
                question: _questionController.text,
                answer: _answerController.text,
              );

              final provider = Provider.of<FlashcardProvider>(context, listen: false);
              if (existing == null) {
                provider.addCard(newCard);
              } else if (index != null) {
                provider.editCard(index, newCard);
              }

              Navigator.of(context).pop();
            },
            child: Text(existing == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final flashcardProvider = Provider.of<FlashcardProvider>(context);
    final currentCard = flashcardProvider.currentCard;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Quiz'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              flashcardProvider.resetScore();
              setState(() {
                feedback = null;
                _showAnswer = false;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FlashcardWidget(question: currentCard.question),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Card ${flashcardProvider.currentIndex + 1} / ${flashcardProvider.totalCards}"),
              ],
            ),
            if (_showAnswer)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("Answer: ${currentCard.answer}", style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Your Answer',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                flashcardProvider.checkAnswer(_controller.text);
                setState(() {
                  feedback = _controller.text.trim().toLowerCase() ==
                      currentCard.answer.toLowerCase()
                      ? "Correct!"
                      : "Wrong! Try next.";
                  _showAnswer = true;
                });
              },
              child: const Text('Check Answer'),
            ),
            if (feedback != null)
              Text(
                feedback!,
                style: TextStyle(
                  color: feedback == "Correct!" ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 10),
            Text("Score: ${flashcardProvider.score}"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: flashcardProvider.previousCard,
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: flashcardProvider.nextCard,
                  child: const Text('Next'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _showFlashcardDialog(existing: currentCard, index: flashcardProvider.currentIndex),
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    final index = flashcardProvider.currentIndex;
                    flashcardProvider.deleteCard(index);
                    flashcardProvider.setIndex(0);
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFlashcardDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
