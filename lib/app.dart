import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_hike/common/constants.dart/app_string.dart';
import 'package:m_hike/di/di.dart';
import 'package:m_hike/presentation/routes/app_router.dart';

class Application extends StatelessWidget {
  const Application({super.key});
  AppRouter get _autoRouter => getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(355.02, 690),
        builder: (context, child) {
          return MaterialApp.router(
            title: AppString.title_app,
            debugShowCheckedModeBanner: false,
            routeInformationParser: _autoRouter.defaultRouteParser(),
            routerDelegate: _autoRouter.delegate(),
          );
        });
  }
}
