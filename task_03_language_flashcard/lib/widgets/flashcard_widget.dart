// lib/widgets/flashcard_widget.dart
import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardWidget extends StatelessWidget {
  final Flashcard card;

  const FlashcardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(card.question),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Answer: ${card.answer}'),
            Text('Pronunciation: ${card.pronunciation}'),
            Text('Language: ${card.language}'),
            Text('Category: ${card.category}'),
          ],
        ),
      ),
    );
  }
}
