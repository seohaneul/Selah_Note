import 'package:isar/isar.dart';

part 'highlight_model.g.dart';

@collection
class HighlightModel {
  Id id = Isar.autoIncrement;

  final int bookId;
  final int chapter;
  final int verse;
  final int startIndex;
  final int endIndex;
  final int colorCode; // Color value

  HighlightModel({
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.startIndex,
    required this.endIndex,
    required this.colorCode,
  });
}
