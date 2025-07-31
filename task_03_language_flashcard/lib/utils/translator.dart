import 'package:google_mlkit_translation/google_mlkit_translation.dart';

/// ✅ Step 1: Define language code → TranslateLanguage mapping
final Map<String, TranslateLanguage> translateLanguageMap = {
  'en': TranslateLanguage.english,
  'ur': TranslateLanguage.urdu,
  'hi': TranslateLanguage.hindi,
  'es': TranslateLanguage.spanish,
  'fr': TranslateLanguage.french,
  'de': TranslateLanguage.german,
  'ar': TranslateLanguage.arabic,
  'zh': TranslateLanguage.chinese,
  'ru': TranslateLanguage.russian,
  'ja': TranslateLanguage.japanese,
  'ko': TranslateLanguage.korean,
  // Add more languages as needed
};

/// ✅ Step 2: Translation service using ML Kit
class TranslatorService {
  final OnDeviceTranslator translator;

  TranslatorService({
    required String sourceLangCode,
    required String targetLangCode,
  }) : translator = OnDeviceTranslator(
    sourceLanguage: translateLanguageMap[sourceLangCode]!,
    targetLanguage: translateLanguageMap[targetLangCode]!,
  );

  /// ✅ Download language model if not already available
  static Future<void> downloadModelsIfNeeded(String langCode) async {
    final manager = OnDeviceTranslatorModelManager();
    final lang = translateLanguageMap[langCode]!;

    if (!await manager.isModelDownloaded(lang.bcpCode)) {
      await manager.downloadModel(lang.bcpCode);
    }
  }

  /// ✅ Perform translation
  Future<String> translate(String input) async {
    return await translator.translateText(input);
  }

  /// ✅ Always close translator to free memory
  void dispose() => translator.close();
}
