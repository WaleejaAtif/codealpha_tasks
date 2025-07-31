import 'dart:math';
import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../widgets/quote_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Quote> _quotes = [
    Quote(text: "Be yourself; everyone else is already taken.", author: "Oscar Wilde"),
    Quote(text: "Two things are infinite: the universe and human stupidity.", author: "Albert Einstein"),
    Quote(text: "So many books, so little time.", author: "Frank Zappa"),
    Quote(text: "A room without books is like a body without a soul.", author: "Marcus Tullius Cicero"),
    Quote(text: "Be the change that you wish to see in the world.", author: "Mahatma Gandhi"),
  ];

  late Quote _currentQuote;

  void _generateRandomQuote() {
    final random = Random();
    setState(() {
      _currentQuote = _quotes[random.nextInt(_quotes.length)];
    });
  }

  @override
  void initState() {
    super.initState();
    _generateRandomQuote(); // Set an initial quote
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Random Quote Generator"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuoteCard(quote: _currentQuote),
          ElevatedButton(
            onPressed: _generateRandomQuote,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              "New Quote",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
