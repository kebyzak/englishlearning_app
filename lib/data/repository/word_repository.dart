import 'package:http/http.dart' as http;
import 'dart:convert';

class WordRepository {
  final String apiKey = 'lyez0hs7jslgv3wj9ylyuz1vnm985069mzos8twt50flmrnfj';
  final String apiUrl = 'https://api.wordnik.com/v4/word.json';

  Future<List<String>> fetchWord(String word) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$apiUrl/$word/definitions?limit=2&includeRelated=false&sourceDictionaries=ahd-5&useCanonical=true&includeTags=false&api_key=$apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        final definitions = data
            .map((item) => item['text'] as String?)
            .where((text) => text != null)
            .map((text) => text!.replaceAll(RegExp(r'<[^>]*>'), ''))
            .toList();

        return definitions;
      } else {
        throw Exception('Failed to fetch word definitions');
      }
    } catch (e) {
      throw Exception('Failed to fetch word definitions');
    }
  }

  Future<String?> fetchAudioUrl(String word) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$apiUrl/$word/audio?useCanonical=false&limit=1&api_key=$apiKey'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> audioList = jsonDecode(response.body);
        if (audioList.isNotEmpty) {
          final audioData = audioList.first;
          if (audioData.containsKey('fileUrl')) {
            return audioData['fileUrl'];
          }
        }
      }
    } catch (e) {
      throw Exception('Failed to fetch word audio');
    }
    return null;
  }
}
