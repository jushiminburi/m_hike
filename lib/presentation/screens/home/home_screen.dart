import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_tab_bar/library.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:m_hike/common/constants.dart/constants.dart';
import 'package:m_hike/common/utils.dart';
import 'package:m_hike/domain/models/hike.dart';
import 'package:m_hike/domain/models/weather.dart';
import 'package:m_hike/presentation/routes/app_router.dart';
import 'package:m_hike/presentation/screens/home/bloc/home_bloc.dart';
import 'package:m_hike/presentation/screens/home/views/app_bar.dart';
import 'package:m_hike/presentation/views/textfield_view.dart';
import 'package:m_hike/presentation/widget/ellipsis_text.dart';

import 'views/empty_search.dart';

@RoutePage()
class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();
  final CustomTabBarController _tabBarController = CustomTabBarController();
  static const pageCount = 3;

  @override
  void initState() {
    context.read<HomeBloc>().add(HomeEvent.initial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBarHomeView(weather: state.weather, time: state.time),
          backgroundColor: Colors.white,
          body: Container(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
              width: 1.sw,
              height: 1.sh,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Let\'s see',
                        style: AppTypography.title.copyWith(fontSize: 26.sp)),
                    Text('Your Hikes',
                        style:
                            AppTypography.headline2.copyWith(fontSize: 28.sp)),
                    Gap(20.sp),
                    TextFieldView(
                        controller: _searchController,
                        placeholder: AppString.placeholer_search,
                        suffix: SvgPicture.asset(AppImage.search),
                        onChanged: (value) {},
                        onSubmitted: (value) {}),
                    Gap(10.h),
                    CustomTabBar(
                        height: 40.h,
                        tabBarController: _tabBarController,
                        indicator: StandardIndicator(
                            radius: BorderRadius.circular(3.5.w),
                            width: 7.w,
                            height: 7.w,
                            color: Colors.black),
                        builder: (_, i) => TabBarItem(
                            index: i,
                            transform: ScaleTransform(
                                maxScale: 1.2,
                                builder: (_, scale) => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      alignment: Alignment.center,
                                      constraints:
                                          const BoxConstraints(minWidth: 70),
                                      child: Text(
                                          i == 0
                                              ? AppString.latest
                                              : i == 1
                                                  ? AppString.comming_soon
                                                  : AppString.completed,
                                          style: AppTypography.title.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                    ))),
                        itemCount: pageCount,
                        pageController: _pageController),
                    Gap(10.w),
                    Flexible(
                        child: PageView.builder(
                            controller: _pageController,
                            itemCount: pageCount,
                            itemBuilder: (_, i) {
                              if (i == 0) {
                                return _listHikeSearch(
                                    hikes: state.hikes?.latest);
                              }
                              if (i == 1) {
                                return _listHikeSearch(
                                    hikes: state.hikes?.comingSoon);
                              } else {
                                return _listHikeSearch(
                                    hikes: state.hikes?.completed);
                              }
                            }))
                  ])),
          floatingActionButton: FloatingActionButton.extended(
              backgroundColor: AppColor.blueIII,
              onPressed: () => context.router.push(CreateUpdateHikeRoute()),
              label: Row(children: [
                SvgPicture.asset(AppImage.create_hike,
                    height: 25.h, width: 25.h),
                Gap(5.w),
                Text('Create Hike',
                    style: AppTypography.headline1
                        .copyWith(fontWeight: FontWeight.w500))
              ])));
    });
  }

  Widget _listHikeSearch({List<Hike>? hikes}) {
    return hikes != null && hikes.isNotEmpty
        ? ListView.separated(
            physics: const ClampingScrollPhysics(),
            itemBuilder: (_, index) => GestureDetector(
                onTap: () =>
                    context.router.push(HikeDetailRoute(hike: hikes[index])),
                child: _itemHikeView(hikes[index])),
            separatorBuilder: (BuildContext context, int index) => Gap(10.h),
            itemCount: hikes.length)
        : const EmptyDataSearch();
  }

  Widget _itemHikeView(Hike hike) {
    return Container(
        height: 135,
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColor.grayIII)),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: hike.images != null && hike.images!.isEmpty
                ? Image.asset(
                    AppImage.default_image,
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: 120.w,
                  )
                : Image.memory(Uint8List.fromList(hike.images!.first.image!)),
          ),
          Gap(10.w),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                EllipsisText(hike.routerName,
                    style: AppTypography.title
                        .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
                    maxLines: 2),
                Row(children: [
                  SvgPicture.asset(AppImage.location, height: 20.h),
                  Gap(5.w),
                  Flexible(
                      child: EllipsisText(hike.destinationName,
                          style: AppTypography.title.copyWith(fontSize: 13.sp)))
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        SvgPicture.asset(AppImage.time, height: 20.h),
                        Gap(5.w),
                        EllipsisText(Util.formatDateTime(hike.startTime),
                            style:
                                AppTypography.title.copyWith(fontSize: 12.sp))
                      ]),
                      Row(children: [
                        SvgPicture.asset(AppImage.distance, height: 20.h),
                        EllipsisText('${hike.totalDuration.toString()} km',
                            style:
                                AppTypography.title.copyWith(fontSize: 12.sp))
                      ])
                    ])
              ]))
        ]));
  }
}
