import 'package:isar/isar.dart';

part 'question_model.g.dart';

@collection
class QuestionModel {
  Id id = Isar.autoIncrement;

  final String questionText;
  final String? answerText;
  final bool isResolved;
  
  // List of verse references like "요한복음 3:16"
  final List<String> bibleTags;
  
  final DateTime createdAt;
  final DateTime updatedAt;

  QuestionModel({
    required this.questionText,
    this.answerText,
    required this.isResolved,
    required this.bibleTags,
    required this.createdAt,
    required this.updatedAt,
  });
}
