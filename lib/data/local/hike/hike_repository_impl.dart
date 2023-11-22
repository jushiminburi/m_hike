part of 'hike_repository.dart';

@LazySingleton(as: HikeRepository)
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

  @override
  Future<List<Hike>> fectchLisLatestHike({String keywords = ''}) async {
    List<Hike> result = [];

    if (double.tryParse(keywords) == null) {
      result = await db
          .getDatabase()
          .hikes
          .filter()
          .routerNameContains(keywords)
          .sortByCreated()
          .findAll();
    } else {
      result = await db
          .getDatabase()
          .hikes
          .filter()
          .totalDurationEqualTo(double.parse(keywords))
          .sortByCreated()
          .findAll();
    }
    return result;
  }

  @override
  Future<List<Hike>> fetchListComingSoonHike({String keywords = ''}) async {
    List<Hike> result = [];

    if (double.tryParse(keywords) == null) {
      result = await db
          .getDatabase()
          .hikes
          .filter()
          .routerNameContains(keywords, caseSensitive: false)
          .startTimeGreaterThan(DateTime.now())
          .destinationNameContains(keywords, caseSensitive: false)
          .sortByCreated()
          .findAll();
    } else {
      result = await db
          .getDatabase()
          .hikes
          .filter()
          .startTimeGreaterThan(DateTime.now())
          .totalDurationEqualTo(double.parse(keywords))
          .sortByCreated()
          .findAll();
    }
    return result;
  }

  @override
  Future<List<Hike>> fetchListCompleteHike({String keywords = ''}) async {
    List<Hike> result = [];

    if (double.tryParse(keywords) == null) {
      result = await db
          .getDatabase()
          .hikes
          .filter()
          .routerNameContains(keywords, caseSensitive: false)
          .completedEqualTo(true)
          .destinationNameContains(keywords, caseSensitive: false)
          .sortByCreated()
          .findAll();
    } else {
      result = await db
          .getDatabase()
          .hikes
          .filter()
          .completedEqualTo(true)
          .totalDurationEqualTo(double.parse(keywords))
          .sortByCreated()
          .findAll();
    }
    return result;
  }
}
