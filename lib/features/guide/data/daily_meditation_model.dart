import 'package:isar/isar.dart';

part 'daily_meditation_model.g.dart';

@collection
class DailyMeditationModel {
  Id id = Isar.autoIncrement;
  
  late int questionId;
  late String tag;
  late String questionText;
  late String answerText;
  
  late DateTime createdAt;
  late DateTime updatedAt;
}
