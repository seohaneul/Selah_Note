// TODO: Add isar or sqflite package dependency
// import 'package:isar/isar.dart';

class LocalDb {
  // static late Isar isar;

  static Future<void> initialize() async {
    // Isar 데이터베이스 초기화 로직
    // final dir = await getApplicationDocumentsDirectory();
    // isar = await Isar.open(
    //   [HighlightSchema, MemoSchema],
    //   directory: dir.path,
    // );
    print("Local DB initialized (mock)");
  }
}
