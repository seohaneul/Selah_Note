import 'package:flutter/material.dart';
import '../../features/bible/data/highlight_model.dart';

class HighlightParser {
  static List<TextSpan> buildVerseSpans(String fullText, List<HighlightModel> highlights) {
    List<TextSpan> spans = [];
    int currentIndex = 0;

    highlights.sort((a, b) => a.startIndex.compareTo(b.startIndex));

    for (var hl in highlights) {
      if (hl.startIndex >= fullText.length || hl.startIndex < currentIndex) continue;
      
      int end = hl.endIndex > fullText.length ? fullText.length : hl.endIndex;

      if (hl.startIndex > currentIndex) {
        spans.add(TextSpan(
          text: fullText.substring(currentIndex, hl.startIndex),
          style: const TextStyle(color: Colors.black87),
        ));
      }
      
      spans.add(TextSpan(
        text: fullText.substring(hl.startIndex, end),
        style: TextStyle(backgroundColor: Color(hl.colorCode)),
      ));
      
      currentIndex = end;
    }

    if (currentIndex < fullText.length) {
      spans.add(TextSpan(
        text: fullText.substring(currentIndex),
        style: const TextStyle(color: Colors.black87),
      ));
    }

    return spans;
  }
}
