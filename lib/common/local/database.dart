import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:m_hike/domain/models/hike.dart';
import 'package:m_hike/domain/models/image.dart';
import 'package:path_provider/path_provider.dart';

part 'database_impl.dart';

abstract class Database {
  Future<void> init();
  Isar getDatabase();
  Future<void> clean();
}
