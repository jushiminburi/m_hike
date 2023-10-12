import 'package:auto_route/auto_route.dart';
import 'package:m_hike/presentation/screens/hiking/hiking_screen.dart';

import '../screens/hike/hike.dart';
import '../screens/home/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoutes.page),
        AutoRoute(page: CreateUpdateHikeRoute.page),
        AutoRoute(page: HikingRoute.page, initial: true),
      ];
}
