import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardProvider with ChangeNotifier {
  List<Flashcard> _cards = [
    Flashcard(question: "What is the powerhouse of the cell?", answer: "Mitochondria"),
    Flashcard(question: "What is the capital of Japan?", answer: "Tokyo"),
    Flashcard(question: "What does HTTP stand for?", answer: "HyperText Transfer Protocol"),
  ];

  int _currentIndex = 0;
  int _score = 0;

  List<Flashcard> get cards => _cards;
  int get currentIndex => _currentIndex;
  int get score => _score;
  int get totalCards => _cards.length;

  Flashcard get currentCard => _cards[_currentIndex];

  void nextCard() {
    if (_currentIndex < _cards.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousCard() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void checkAnswer(String userAnswer) {
    if (userAnswer.trim().toLowerCase() == currentCard.answer.toLowerCase()) {
      _score++;
    }
    notifyListeners();
  }

  void resetScore() {
    _score = 0;
    notifyListeners();
  }

  void addCard(Flashcard card) {
    _cards.add(card);
    notifyListeners();
  }

  void deleteCard(int index) {
    if (index >= 0 && index < _cards.length) {
      _cards.removeAt(index);

      // Adjust current index if necessary
      if (_cards.isEmpty) {
        _currentIndex = 0;
      } else if (_currentIndex >= _cards.length) {
        _currentIndex = _cards.length - 1;
      }

      notifyListeners();
    }
  }

  void editCard(int index, Flashcard updatedCard) {
    if (index >= 0 && index < _cards.length) {
      _cards[index] = updatedCard;
      notifyListeners();
    }
  }

  void setIndex(int i) {
    if (i >= 0 && i < _cards.length) {
      _currentIndex = i;
      notifyListeners();
    }
  }
}
