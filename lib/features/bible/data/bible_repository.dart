import 'dart:convert';
import 'package:flutter/services.dart';
import 'bible_model.dart';

class BibleRepository {
  static final Map<String, String> _bibleData = {};

  static Future<void> loadBible() async {
    if (_bibleData.isNotEmpty) return;
    try {
      final String response = await rootBundle.loadString('assets/bible.json');
      final Map<String, dynamic> data = json.decode(response);
      
      data.forEach((key, value) {
        _bibleData[key] = value.toString();
      });
      print("Bible loaded: ${_bibleData.length} verses.");
    } catch (e) {
      print("Failed to load bible.json: $e");
    }
  }

  static List<Verse> getChapterVerses(String bookName, int chapter) {
    List<Verse> verses = [];
    String prefix = "$bookName$chapter:";
    
    List<MapEntry<String, String>> matchingEntries = _bibleData.entries
        .where((e) => e.key.startsWith(prefix))
        .toList();

    for (var entry in matchingEntries) {
      String keyStr = entry.key; // "창1:12"
      List<String> parts = keyStr.split(':');
      if (parts.length == 2) {
        int verseNum = int.tryParse(parts[1]) ?? 0;
        if (verseNum > 0) {
          verses.add(Verse(
            bookName: bookName,
            chapter: chapter,
            verse: verseNum,
            text: entry.value.trim(),
          ));
        }
      }
    }
    
    verses.sort((a, b) => a.verse.compareTo(b.verse));
    return verses;
  }
}
