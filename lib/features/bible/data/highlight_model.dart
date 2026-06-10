import 'package:isar/isar.dart'; // 1. Isar 패키지 불러오기

part 'highlight_model.g.dart'; // 2. 자동 생성 파일 연결

@collection
class HighlightModel {
  Id id = Isar.autoIncrement; // 4. 고유 식별자 (자동 증가)

  @Index() // 5. 색인(인덱스) 추가
  final String bookName; // 성경 책 이름 (예: 창세기)
  @Index()
  final int chapter; // 장
  @Index()
  final int verse; // 절
  final int startIndex; // 구절 내 시작 인덱스
  final int endIndex; // 구절 내 끝 인덱스
  final int colorCode;

  final String highlightedText; // 저장된 텍스트
  final String? comment; // 메모/코멘트 (선택사항)
  final DateTime createdAt; // 저장 시점

  HighlightModel({
    required this.bookName,
    required this.chapter,
    required this.verse,
    required this.startIndex,
    required this.endIndex,
    required this.colorCode,
    required this.highlightedText,
    this.comment,
    required this.createdAt,
  });
}
