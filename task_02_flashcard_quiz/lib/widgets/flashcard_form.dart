import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardForm extends StatefulWidget {
  final Flashcard? initialCard;
  final void Function(String question, String answer) onSubmit;

  const FlashcardForm({super.key, this.initialCard, required this.onSubmit});

  @override
  State<FlashcardForm> createState() => _FlashcardFormState();
}

class _FlashcardFormState extends State<FlashcardForm> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialCard != null) {
      _questionController.text = widget.initialCard!.question;
      _answerController.text = widget.initialCard!.answer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _questionController,
            decoration: const InputDecoration(labelText: 'Question'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _answerController,
            decoration: const InputDecoration(labelText: 'Answer'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              widget.onSubmit(
                _questionController.text,
                _answerController.text,
              );
              Navigator.of(context).pop();
            },
            child: Text(widget.initialCard == null ? 'Add Flashcard' : 'Update Flashcard'),
          ),
        ],
      ),
    );
  }
}
