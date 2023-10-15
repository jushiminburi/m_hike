import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:m_hike/common/local/database.dart';
import 'package:m_hike/domain/models/exception/app_error.dart';
import 'package:m_hike/domain/models/hike.dart';
import 'package:dartz/dartz.dart';
part 'hike_repository_impl.dart';

abstract class HikeRepository {
  Future cacheHikeToLocal(Hike hike);
  Future<Either<AppError, Hike>> fetchCacheHike(int id);
  Future<Either<AppError, List<Hike>>> fectchListHike(String keywords);
  Future<Either<AppError, bool>> hikeOutOfLocal(int id);
}
