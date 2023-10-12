part of 'hike_repository.dart';

@LazySingleton(as:HikeRepository )
class HikeRepositoryImpl implements HikeRepository {
  Database db;
  HikeRepositoryImpl(this.db);
  @override
  Future cacheHikeToLocal(Hike hike) async {
    await db.getDatabase().writeTxn(() async {
      final cached = await db
          .getDatabase()
          .hikes
          .filter()
          .isarIdEqualTo(hike.isarId)
          .findFirst();
      if (cached == null) {
        await db.getDatabase().hikes.put(hike);
      } else {
        await db.getDatabase().hikes.put(hike.copyWith(isarId: hike.isarId));
      }
    });
  }

  @override
  Future<Either<AppError, Hike>> fetchCacheHike(int id) async {
    final hike =
        await db.getDatabase().hikes.filter().isarIdEqualTo(id).findFirst();
    if (hike == null) {
      return left(AppError(message: 'Hike not found'));
    } else {
      return right(hike);
    }
  }

  @override
  Future<Either<AppError, bool>> hikeOutOfLocal(int id) async {
    final isDeleted =
        await db.getDatabase().hikes.filter().isarIdEqualTo(id).deleteFirst();
    if (isDeleted) {
      return right(isDeleted);
    } else {
      return left(AppError(message: 'Delete hike failed'));
    }
  }
}
