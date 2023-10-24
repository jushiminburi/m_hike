import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:m_hike/common/constants.dart/app_typography.dart';
import 'package:m_hike/domain/models/weather.dart';

class AppBarHomeView extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHomeView({super.key, this.weather, this.time, this.icon});
  final Weather? weather;
  final String? time;
  final String? icon;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.only(left: 10.w, top: 10.h),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(
                  backgroundColor: Colors.amberAccent,
                  child: Image.network(
                      'https:${weather?.current.condition.icon}')),
              Gap(10.w),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time ?? '',
                      style: AppTypography.headline2,
                    ),
                    Text(
                      '${weather?.current.tempC} °C',
                      style: AppTypography.title,
                    ),
                  ])
            ])));
  }

  @override
  Size get preferredSize => Size.fromHeight(0.12.sh);
}
