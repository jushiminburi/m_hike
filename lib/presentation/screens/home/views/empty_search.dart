import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m_hike/common/constants.dart/constants.dart';

class EmptyDataSearch extends StatelessWidget {
  const EmptyDataSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsetsDirectional.symmetric(vertical: 100.h),
        alignment: Alignment.center,
        height: 200.h,
        width: 1.sw,
        child: Column(
          children: [SvgPicture.asset(AppImage.empty), const Text('No Data')],
        ));
  }
}
