import 'dart:convert';
import 'package:flutter/services.dart';
import 'bible_model.dart';

class BibleRepository {
  static final Map<String, String> _bibleData = {};
  
  static final List<String> books = [];
  static final Map<String, int> bookMaxChapters = {};
  static final List<MapEntry<String, int>> allChapters = [];

  static Future<void> loadBible() async {
    if (_bibleData.isNotEmpty) return;
    try {
      final String response = await rootBundle.loadString('assets/bible.json');
      final Map<String, dynamic> data = json.decode(response);
      
      final regex = RegExp(r'^([^\d]+)(\d+):');
      
      data.forEach((key, value) {
        _bibleData[key] = value.toString();
        
        final match = regex.firstMatch(key);
        if (match != null) {
          String bookName = match.group(1)!;
          int chapter = int.parse(match.group(2)!);
          
          if (!books.contains(bookName)) {
            books.add(bookName);
          }
          
          if ((bookMaxChapters[bookName] ?? 0) < chapter) {
            bookMaxChapters[bookName] = chapter;
          }
        }
      });
      
      for (String book in books) {
        int maxCh = bookMaxChapters[book] ?? 1;
        for (int i = 1; i <= maxCh; i++) {
          allChapters.add(MapEntry(book, i));
        }
      }
      
      print("Bible loaded: ${_bibleData.length} verses, ${allChapters.length} chapters.");
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
