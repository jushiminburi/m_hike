import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:m_hike/common/constants.dart/app_typography.dart';

class AppBarHomeView extends StatefulWidget implements PreferredSizeWidget {
  const AppBarHomeView({super.key});

  @override
  State<AppBarHomeView> createState() => _AppBarHomeViewState();

  @override
  Size get preferredSize => Size.fromHeight(0.12.sh);
}

class _AppBarHomeViewState extends State<AppBarHomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.only(left: 10.w, top: 10.h),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const CircleAvatar(
                backgroundColor: Colors.amberAccent,
              ),
              Gap(10.w),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning',
                      style: AppTypography.headline2,
                    ),
                    Text(
                      '28 °C',
                      style: AppTypography.title,
                    ),
                  ])
            ])));
  }
}
