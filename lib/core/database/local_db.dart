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
    
    // V2 마이그레이션을 위한 초기화 코드는 삭제했습니다. 이제 데이터가 보존됩니다.
    print("Local DB (Isar) initialized for V2.");
  }
}
