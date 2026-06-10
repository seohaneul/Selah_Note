class Memo {
  final String id;
  final int bookId;
  final int chapter;
  final int verse;
  final String content;
  final String status; // 'general', 'unresolved_question', 'resolved_question'
  final DateTime createdAt;

  Memo({
    required this.id,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.content,
    required this.status,
    required this.createdAt,
  });

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(
      id: json['id'],
      bookId: json['bookId'],
      chapter: json['chapter'],
      verse: json['verse'],
      content: json['content'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
