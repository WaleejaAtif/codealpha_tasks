import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard.dart';
import '../providers/flashcard_provider.dart';

class AddEditScreen extends StatefulWidget {
  final Flashcard? flashcard;
  final int? index;

  const AddEditScreen({super.key, this.flashcard, this.index});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late TextEditingController _answerController;
  late TextEditingController _categoryController;
  late TextEditingController _languageController;
  late TextEditingController _pronunciationController;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.flashcard?.question ?? '');
    _answerController = TextEditingController(text: widget.flashcard?.answer ?? '');
    _categoryController = TextEditingController(text: widget.flashcard?.category ?? '');
    _languageController = TextEditingController(text: widget.flashcard?.language ?? '');
    _pronunciationController = TextEditingController(text: widget.flashcard?.pronunciation ?? '');
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    _categoryController.dispose();
    _languageController.dispose();
    _pronunciationController.dispose();
    super.dispose();
  }

  void _saveCard() {
    if (_formKey.currentState!.validate()) {
      final newCard = Flashcard(
        question: _questionController.text.trim(),
        answer: _answerController.text.trim(),
        category: _categoryController.text.trim(),
        language: _languageController.text.trim(),
        pronunciation: _pronunciationController.text.trim(),
      );

      final provider = Provider.of<FlashcardProvider>(context, listen: false);

      if (widget.index != null) {
        provider.updateCard(widget.index!, newCard); // ✅ use correct method name
      } else {
        provider.addCard(newCard);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.index != null ? 'Edit Flashcard' : 'Add Flashcard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(labelText: 'Question'),
                validator: (value) => value!.isEmpty ? 'Enter a question' : null,
              ),
              TextFormField(
                controller: _answerController,
                decoration: const InputDecoration(labelText: 'Answer'),
                validator: (value) => value!.isEmpty ? 'Enter an answer' : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) => value!.isEmpty ? 'Enter a category' : null,
              ),
              TextFormField(
                controller: _languageController,
                decoration: const InputDecoration(labelText: 'Language'),
                validator: (value) => value!.isEmpty ? 'Enter a language' : null,
              ),
              TextFormField(
                controller: _pronunciationController,
                decoration: const InputDecoration(labelText: 'Pronunciation'),
                validator: (value) => value!.isEmpty ? 'Enter pronunciation' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveCard,
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
