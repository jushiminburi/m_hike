// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:m_hike/common/constants.dart/constants.dart';
import 'package:m_hike/common/utils.dart';
import 'package:m_hike/domain/models/hike.dart';
import 'package:m_hike/presentation/routes/app_router.dart';
import 'package:m_hike/presentation/screens/hike/detail/bloc/detail_hike_bloc.dart';
import 'package:m_hike/presentation/widget/ellipsis_text.dart';

@RoutePage()
class HikeDetailScreen extends StatefulWidget {
  const HikeDetailScreen(
      {super.key, required this.hike, this.isCreate = false});
  final Hike hike;
  final bool isCreate;
  @override
  State<HikeDetailScreen> createState() => _HikeDetailScreenState();
}

class _HikeDetailScreenState extends State<HikeDetailScreen> {
  @override
  void initState() {
    context.read<DetailHikeBloc>().add(DetailHikeEvent.initial(widget.hike));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailHikeBloc, DetailHikeState>(builder: (_, state) {
      final Hike hike = state.hike;
      return Scaffold(
          bottomNavigationBar:
              _bottomNavigationBar(context, hike, widget.isCreate),
          body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(children: [
                hike.imagesPath == null || hike.imagesPath!.isEmpty
                    ? Image.asset(
                        AppImage.default_image,
                        height: 0.43.sh,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      )
                    : Image.file(File(hike.imagesPath![0]),
                        fit: BoxFit.fitWidth),
                Positioned(
                    bottom: 0,
                    child: Container(
                        width: 1.sw,
                        height: 0.6.sh,
                        padding:
                            EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.vertical(
                                top: Radius.circular(30.r))),
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(hike.routerName,
                                    style: AppTypography.headline1.copyWith(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w700)),
                                Gap(20.h),
                                Row(
                                  children: [
                                    Row(children: [
                                      Container(
                                        padding:
                                            EdgeInsetsDirectional.symmetric(
                                                horizontal: 7.w, vertical: 7.w),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            border:
                                                Border.all(color: Colors.white),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: AppColor.grayI,
                                                  blurRadius: 3.r,
                                                  offset: const Offset(3, 3),
                                                  blurStyle: BlurStyle.normal)
                                            ]),
                                        height: 40.h,
                                        width: 40.h,
                                        child: SvgPicture.asset(
                                          AppImage.location,
                                          height: 10.h,
                                          color: AppColor.blueIII,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Gap(10.w),
                                      Text(
                                        '${hike.totalDuration.toString()} KM',
                                        style: AppTypography.title
                                            .copyWith(color: AppColor.blueIII),
                                      )
                                    ]),
                                    Gap(30.w),
                                    Expanded(
                                      child: EllipsisText(
                                        hike.destinationName,
                                        maxLines: 3,
                                        style: AppTypography.headline2.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                Gap(20.h),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.w),
                                  child: SizedBox(
                                      height: 150.h,
                                      child: hike.coordinatePlaceOfOrigin !=
                                              null && hike.coordinateDestination!=null
                                          ? GoogleMap(
                                              onMapCreated: state.onCreateMap,
                                              zoomGesturesEnabled: true,
                                              myLocationButtonEnabled: false,
                                              initialCameraPosition: CameraPosition(
                                                  target: LatLng(
                                                      hike.coordinatePlaceOfOrigin?.lat ??
                                                          0,
                                                      hike.coordinatePlaceOfOrigin?.lng ??
                                                          0),
                                                  zoom: getBoundsZoomLevel(
                                                      LatLngBounds(
                                                          southwest: (hike.coordinatePlaceOfOrigin!.lat <= hike.coordinateDestination!.lat)
                                                              ? LatLng(
                                                                  hike.coordinatePlaceOfOrigin?.lat ??
                                                                      0,
                                                                  hike.coordinatePlaceOfOrigin?.lng ??
                                                                      0)
                                                              : LatLng(
                                                                  hike.coordinateDestination?.lat ??
                                                                      0,
                                                                  hike.coordinateDestination?.lng ??
                                                                      0),
                                                          northeast: (hike.coordinatePlaceOfOrigin!.lat <=
                                                                  hike.coordinateDestination!.lat)
                                                              ? LatLng(hike.coordinateDestination?.lat ?? 0, hike.coordinateDestination?.lng ?? 0)
                                                              : LatLng(hike.coordinatePlaceOfOrigin?.lat ?? 0, hike.coordinatePlaceOfOrigin?.lng ?? 0)),
                                                      Size(1.sw, 150.h))),
                                              markers: {
                                                Marker(
                                                    markerId: const MarkerId(
                                                        "_startLocation"),
                                                    icon: BitmapDescriptor
                                                        .defaultMarker,
                                                    position: LatLng(
                                                        hike.coordinatePlaceOfOrigin
                                                                ?.lat ??
                                                            0,
                                                        hike.coordinatePlaceOfOrigin
                                                                ?.lng ??
                                                            0)),
                                                Marker(
                                                  markerId: const MarkerId(
                                                      "_destionationLocation"),
                                                  icon: BitmapDescriptor
                                                      .defaultMarker,
                                                  position: LatLng(
                                                      hike.coordinateDestination
                                                              ?.lat ??
                                                          0,
                                                      hike.coordinateDestination
                                                              ?.lng ??
                                                          0),
                                                )
                                              },
                                            )
                                          : const SizedBox()),
                                ),
                                Gap(20.h),
                                Text(
                                  'Descriptions',
                                  style: AppTypography.headline2
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                Gap(10.h),
                                _descriptionDetail(
                                    AppImage.parking,
                                    hike.isParkingRouter
                                        ? 'Available '
                                        : 'Unavailable'),
                                Gap(10.h),
                                _descriptionDetail(
                                    AppImage.difficulty,
                                    hike.levelDifficultRouter == 1
                                        ? 'Easy'
                                        : hike.levelDifficultRouter == 2
                                            ? 'Normal'
                                            : 'Difficulty'),
                                Gap(10.h),
                                _descriptionDetail(AppImage.time,
                                    Util.formatDateTime(hike.startTime)),
                                Gap(20.h),
                                EllipsisText(hike.description,
                                    maxLines: 20,
                                    style: AppTypography.title
                                        .copyWith(color: AppColor.grayIII)),
                                Gap(20.h),
                                Text(
                                  'Images',
                                  style: AppTypography.headline2
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                GridView.builder(
                                    itemCount: hike.imagesPath?.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3),
                                    itemBuilder: (context, index) => Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.w, vertical: 5.h),
                                        child: Image.file(
                                            File(hike.imagesPath![index]),
                                            fit: BoxFit.contain)))
                              ]),
                        ))),
                Positioned(
                  top: 1,
                  left: 10,
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: () => context.router.navigate(const HomeRoutes()),
                      child: SvgPicture.asset(
                        AppImage.left_arrow,
                        width: 25.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ])));
    });
  }

  double getBoundsZoomLevel(LatLngBounds bounds, Size mapDimensions) {
    var worldDimension = const Size(1024, 1024);
    double latRad(lat) {
      var sinValue = sin(lat * pi / 180);
      var radX2 = log((1 + sinValue) / (1 - sinValue)) / 2;
      return max(min(radX2, pi), -pi) / 2;
    }

    double zoom(mapPx, worldPx, fraction) {
      return (log(mapPx / worldPx / fraction) / ln2).floorToDouble();
    }

    var ne = bounds.northeast;
    var sw = bounds.southwest;

    var latFraction = (latRad(ne.latitude) - latRad(sw.latitude)) / pi;

    var lngDiff = ne.longitude - sw.longitude;
    var lngFraction = ((lngDiff < 0) ? (lngDiff + 360) : lngDiff) / 360;

    var latZoom =
        zoom(mapDimensions.height, worldDimension.height, latFraction);
    var lngZoom = zoom(mapDimensions.width, worldDimension.width, lngFraction);

    if (latZoom < 0) return lngZoom;
    if (lngZoom < 0) return latZoom;

    return min(latZoom, lngZoom);
  }

  Widget _bottomNavigationBar(BuildContext context, Hike hike, bool isCreate) =>
      isCreate
          ? Container(
              width: 1.sw,
              padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 15.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => context.router.pop(),
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColor.blueIII,
                                borderRadius: BorderRadius.circular(25.r)),
                            height: 50.h,
                            child: Text('Edit',
                                style: AppTypography.headline1.copyWith(
                                    color: Colors.white,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                    Gap(20.w),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        context
                            .read<DetailHikeBloc>()
                            .add(DetailHikeEvent.save(hike));
                        context.router.push(const HomeRoutes());
                      },
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColor.blueIII,
                              borderRadius: BorderRadius.circular(25.r)),
                          height: 50.h,
                          child: Text('Save',
                              style: AppTypography.headline1.copyWith(
                                  color: Colors.white,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w700))),
                    ))
                  ]),
            )
          : Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.h),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                          onTap: () => context.router
                              .navigate(CreateUpdateHikeRoute(hike: hike)),
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColor.blueIII,
                                  borderRadius: BorderRadius.circular(25.r)),
                              height: 50.h,
                              child: Text('Edit',
                                  style: AppTypography.headline1.copyWith(
                                      color: Colors.white,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w700))))),
                  Gap(10.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.router.push(HikingRoute(hike: hike)),
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColor.blueIII,
                              borderRadius: BorderRadius.circular(25.r)),
                          height: 50.h,
                          child: Text('Start',
                              style: AppTypography.headline1.copyWith(
                                  color: Colors.white,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700))),
                    ),
                  ),
                ],
              ),
            );

  Widget _descriptionDetail(String image, String info) => Row(
        children: [
          SvgPicture.asset(image, height: 30, fit: BoxFit.fill),
          Gap(10.h),
          Text(
            info,
            style: AppTypography.title.copyWith(color: AppColor.grayIII),
          ),
        ],
      );
}
