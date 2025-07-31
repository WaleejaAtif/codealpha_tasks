import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final List<String> languages;
  final String? selectedLanguage;
  final Function(String?) onLanguageChanged;

  const LanguageSelector({
    super.key,
    required this.languages,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedLanguage,
      hint: const Text('Select Language'),
      items: languages.map((lang) {
        return DropdownMenuItem<String>(
          value: lang,
          child: Text(lang),
        );
      }).toList(),
      onChanged: onLanguageChanged,
    );
  }
}
