import 'package:isar/isar.dart';

part 'selah_guide_model.g.dart';

@collection
class SelahGuideModel {
  Id id = Isar.autoIncrement;

  late String templateId;
  
  // 사용자가 어떤 말씀을 묵상했는지 자유롭게 적을 수 있는 필드 (예: "요한복음 3:16")
  String? referenceText;
  
  // 3단계 질문에 대한 사용자의 답변 배열 (항상 length 3)
  late List<String> answers;
  
  late DateTime createdAt;
  late DateTime updatedAt;
}
