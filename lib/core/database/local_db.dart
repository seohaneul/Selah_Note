import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/bible/data/highlight_model.dart';
import '../../features/memo/data/memo_model.dart';

class LocalDb {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HighlightModelSchema, MemoSchema],
      directory: dir.path,
    );
    print("Local DB (Isar) initialized successfully.");
  }
}
