import 'package:isar/isar.dart';

part 'highlight_model.g.dart';

@collection
class HighlightModel {
  Id id = Isar.autoIncrement;

  @Index()
  final String bookName;
  @Index()
  final int chapter;
  @Index()
  final int verse;
  final int startIndex;
  final int endIndex;
  final int colorCode; 
  
  final String highlightedText;
  final String? comment;
  final DateTime createdAt;

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
