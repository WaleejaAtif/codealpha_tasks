import 'package:google_mlkit_translation/google_mlkit_translation.dart';

/// A helper map that converts language code strings to TranslateLanguage enums
final Map<String, TranslateLanguage> translateLanguageMap = {
  'en': TranslateLanguage.english,
  'ur': TranslateLanguage.urdu,
  'hi': TranslateLanguage.hindi,
  'fr': TranslateLanguage.french,
  'es': TranslateLanguage.spanish,
  'ar': TranslateLanguage.arabic,
  'de': TranslateLanguage.german,
  'zh': TranslateLanguage.chinese,
  'ja': TranslateLanguage.japanese,
  'ko': TranslateLanguage.korean,
};

/// Translation service class
class TranslatorService {
  final OnDeviceTranslator translator;

  TranslatorService({
    required String sourceLangCode,
    required String targetLangCode,
  }) : translator = OnDeviceTranslator(
    sourceLanguage: translateLanguageMap[sourceLangCode]!,
    targetLanguage: translateLanguageMap[targetLangCode]!,
  );

  /// ✅ This is the method you asked about
  static Future<void> downloadModelsIfNeeded(String langCode) async {
    final manager = OnDeviceTranslatorModelManager();
    final lang = translateLanguageMap[langCode]!;

    if (!await manager.isModelDownloaded(lang.bcpCode)) {
      await manager.downloadModel(lang.bcpCode); // ✅ pass String not enum
    }
  }

  /// Translate text
  Future<String> translate(String input) async {
    return await translator.translateText(input);
  }

  /// Close translator when done
  void dispose() => translator.close();
}
