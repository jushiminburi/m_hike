import 'package:auto_route/auto_route.dart';
import 'package:m_hike/presentation/screens/hiking/hiking_screen.dart';

import '../screens/hike/create_update_hike/create_update_screen.dart';
import '../screens/home/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoutes.page, initial: true),
        AutoRoute(page: CreateUpdateHikeRoute.page),
        AutoRoute(page: HikingRoute.page),
        AutoRoute(page: HikeDetailRoute.page, initial: true),
      ];
}
