import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/bible/data/highlight_model.dart';
import '../../features/memo/data/memo_model.dart';
import '../../features/memo/data/question_model.dart';
import '../../features/bible/data/bible_repository.dart';

class LocalDb {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HighlightModelSchema, MemoSchema, QuestionModelSchema],
      directory: dir.path,
    );
    
    // V2 마이그레이션: 기존 스키마 구조가 완전히 달라졌으므로 초기화
    await isar.writeTxn(() async {
      await isar.clear();
    });
    
    print("Local DB (Isar) initialized and wiped for V2.");
  }
}
