import 'package:isar/isar.dart';

part 'memo_model.g.dart';

@collection
class Memo {
  Id id = Isar.autoIncrement;

  @Index()
  final String bookName;
  @Index()
  final int chapter;
  @Index()
  final int verse;
  final String content;
  final String status; // 'general', 'unresolved_question', 'resolved_question'
  final DateTime createdAt;

  Memo({
    required this.bookName,
    required this.chapter,
    required this.verse,
    required this.content,
    required this.status,
    required this.createdAt,
  });
}
