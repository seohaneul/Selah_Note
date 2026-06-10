import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/bible/data/highlight_model.dart';
import '../../features/memo/data/memo_model.dart';
import '../../features/bible/data/bible_repository.dart';

class LocalDb {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HighlightModelSchema, MemoSchema],
      directory: dir.path,
    );
    
    await _cleanupOldData();
    
    print("Local DB (Isar) initialized successfully.");
  }

  static Future<void> _cleanupOldData() async {
    // 풀네임 배열 (창세기, 출애굽기 등)
    final fullNames = BibleRepository.bookFullNames.values.toList();
    
    await isar.writeTxn(() async {
      final allHighlights = await isar.highlightModels.where().findAll();
      final oldHighlights = allHighlights.where((hl) => !fullNames.contains(hl.bookName)).toList();
      for (var hl in oldHighlights) {
        await isar.highlightModels.delete(hl.id);
      }
      
      final allMemos = await isar.memos.where().findAll();
      final oldMemos = allMemos.where((memo) => !fullNames.contains(memo.bookName)).toList();
      for (var memo in oldMemos) {
        await isar.memos.delete(memo.id);
      }
      
      if (oldHighlights.isNotEmpty || oldMemos.isNotEmpty) {
        print("Cleaned up ${oldHighlights.length} old highlights and ${oldMemos.length} old memos.");
      }
    });
  }
}
