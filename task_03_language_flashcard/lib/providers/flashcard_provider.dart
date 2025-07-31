// lib/providers/flashcard_provider.dart
import 'package:flutter/foundation.dart';
import '../models/flashcard.dart';

class FlashcardProvider with ChangeNotifier {
  final List<Flashcard> _flashcards = [];

  List<Flashcard> get flashcards => _flashcards;

  void addCard(Flashcard card) {
    _flashcards.add(card);
    notifyListeners();
  }

  void updateCard(int index, Flashcard newCard) {
    _flashcards[index] = newCard;
    notifyListeners();
  }

  void deleteCard(int index) {
    _flashcards.removeAt(index);
    notifyListeners();
  }
}