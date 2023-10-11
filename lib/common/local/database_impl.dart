part of 'database.dart';

@LazySingleton(as: Database)
class DatabaseImpl implements Database {
  late Isar db;
  @override
  Future<void> clean() async {
   return  await db.writeTxn(() => clean());
  }

  @override
  Isar getDatabase() {
    return db;
  }

  @override
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    db = await Isar.open([HikeSchema], directory: dir.path);
  }
}
