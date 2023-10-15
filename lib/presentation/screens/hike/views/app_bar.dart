import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m_hike/common/constants.dart/app_image.dart';

class AppBarCreateUpdateView extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarCreateUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            alignment: Alignment.centerLeft,
            height: 50.h,
            child: GestureDetector(
              onTap: () => context.router.pop(),
              child: SvgPicture.asset(
                AppImage.left_arrow,
                width: 25.w,
              ),
            )));
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
