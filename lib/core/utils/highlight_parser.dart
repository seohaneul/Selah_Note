import 'package:flutter/material.dart';

/// 하이라이트 데이터를 임시로 담기 위한 모델
class HighlightData {
  final int startIndex;
  final int endIndex;
  final Color color;

  HighlightData({
    required this.startIndex,
    required this.endIndex,
    required this.color,
  });
}

class HighlightParser {
  /// 원본 텍스트와 하이라이트 배열을 받아 TextSpan 배열로 반환합니다.
  static List<TextSpan> buildVerseSpans(String fullText, List<HighlightData> highlights) {
    List<TextSpan> spans = [];
    int currentIndex = 0;

    // 시작 인덱스 기준으로 오름차순 정렬
    highlights.sort((a, b) => a.startIndex.compareTo(b.startIndex));

    for (var hl in highlights) {
      // 범위를 벗어난 잘못된 데이터 방어 로직
      if (hl.startIndex >= fullText.length || hl.startIndex < currentIndex) continue;
      
      int end = hl.endIndex > fullText.length ? fullText.length : hl.endIndex;

      // 1. 하이라이트 이전의 기본 텍스트
      if (hl.startIndex > currentIndex) {
        spans.add(TextSpan(
          text: fullText.substring(currentIndex, hl.startIndex),
          style: const TextStyle(color: Colors.black87),
        ));
      }
      
      // 2. 하이라이트된 텍스트
      spans.add(TextSpan(
        text: fullText.substring(hl.startIndex, end),
        style: TextStyle(backgroundColor: hl.color),
      ));
      
      currentIndex = end;
    }

    // 3. 마지막 하이라이트 이후의 남은 텍스트
    if (currentIndex < fullText.length) {
      spans.add(TextSpan(
        text: fullText.substring(currentIndex),
        style: const TextStyle(color: Colors.black87),
      ));
    }

    return spans;
  }
}
