import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:isar/isar.dart';
import 'package:m_hike/common/constants.dart/constants.dart';

@RoutePage()
class HikeDetailScreen extends StatefulWidget {
  const HikeDetailScreen({super.key, required this.idHike});
  final Id idHike;
  @override
  State<HikeDetailScreen> createState() => _HikeDetailScreenState();
}

class _HikeDetailScreenState extends State<HikeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
          Image.asset(
            AppImage.default_image,
            height: size.height * 0.3,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: 0,
            child: Container(
                width: 1.sw,
                height: 0.75.sh,
                padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.vertical(
                        top: Radius.circular(30.r))),
                child: Column(children: [
                  Text('Ta Xua Moutain View And Moc Chau Farm Qua Hay jiee',
                      style: AppTypography.headline1.copyWith(
                          fontSize: 28.sp, fontWeight: FontWeight.w700)),
                  Gap(10.h),
                  Row(children: [
                    Container(
                      padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 7.w, vertical: 7.w),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(blurRadius: 25.r,)
                          ]),
                      height: 40.h,
                      width: 40.h,
                      child: SvgPicture.asset(
                        AppImage.location,
                        height: 10.h,
                        fit: BoxFit.contain,
                      ),
                    )
                  ])
                ])),
          )
        ]),
      ),
    );
  }
}
