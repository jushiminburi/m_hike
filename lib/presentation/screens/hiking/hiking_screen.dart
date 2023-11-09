import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:m_hike/common/constants.dart/app_color.dart';
import 'package:m_hike/common/constants.dart/app_string.dart';
import 'package:m_hike/common/constants.dart/app_typography.dart';
import 'package:m_hike/common/extension/string.dart';
import 'package:m_hike/common/utils.dart';
import 'package:m_hike/domain/models/hike.dart';
import 'package:m_hike/domain/models/observation_hike.dart';
import 'package:m_hike/presentation/screens/hike/hike.dart';
import 'package:m_hike/presentation/screens/hiking/bloc/bloc/observation_add_bloc.dart';

import 'views/map_view.dart';

@RoutePage()
class HikingScreen extends StatefulWidget {
  const HikingScreen({super.key, required this.hike});
  final Hike hike;
  @override
  State<HikingScreen> createState() => _HikingScreenState();
}

class _HikingScreenState extends State<HikingScreen> {
  final TextEditingController nameObsTextController = TextEditingController();
  final TextEditingController timeObsTextController =
      TextEditingController(text: DateFormat.yMMMMd().format(DateTime.now()));
  final TextEditingController reviewObsTextController = TextEditingController();
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              MapView(hike: widget.hike),
              BlocBuilder<ObservationAddBLoc, ObservationAddState>(
                  builder: (_, state) => DraggableScrollableSheet(
                      initialChildSize: 0.1,
                      minChildSize: 0.1,
                      maxChildSize: 0.3,
                      builder: (_, scroll) => ClipRRect(
                            borderRadius: BorderRadiusDirectional.vertical(
                                top: Radius.circular(30.r)),
                            child: Container(
                              padding: EdgeInsets.only(left: 10.w, right: 40.w),
                              color: Colors.white,
                              child: ListView(
                                physics: const ClampingScrollPhysics(),
                                controller: scroll,
                                children: [
                                  componentViewField('Observation Name',
                                      controller: nameObsTextController,
                                      placeholder: 'Please name observation...',
                                      onChanged: (p0) {
                                    context.read<ObservationAddBLoc>().add(
                                        ObservationAddEvent.nameChanged(p0));
                                  }),
                                  Gap(20.h),
                                  TextField(
                                    controller: timeObsTextController,
                                    focusNode: AlwaysDisabledFocusNode(),
                                    decoration: InputDecoration(
                                        hintText:
                                            AppString.choose_date_start_hike,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 5.h),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            borderSide: const BorderSide(
                                                color: AppColor.grayI)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            borderSide: const BorderSide(
                                                color: AppColor.blueI)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            borderSide: const BorderSide(
                                                color: AppColor.redI))),
                                    onTap: () async {
                                      await _selectDate(context);
                                    },
                                  ),
                                  Gap(20.h),
                                  Text('Review',
                                      style: AppTypography.title.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600)),
                                  Gap(10.h),
                                  TextFormField(
                                    maxLines: 7,
                                    controller: reviewObsTextController,
                                    decoration: InputDecoration(
                                        hintText: 'Enter review about hike',
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            borderSide: const BorderSide(
                                                color: AppColor.grayI)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            borderSide: const BorderSide(
                                                color: AppColor.blueI)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            borderSide: const BorderSide(
                                                color: AppColor.redI))),
                                    onChanged: (value) => context
                                        .read<ObservationAddBLoc>()
                                        .add(ObservationAddEvent.reviewChanged(
                                            value)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (state.nameObservation == null ||
                                          state.nameObservation!.isEmpty) {
                                        Util.showFail(
                                            'Please enter name of your observation');
                                      } else {
                                        context.read<ObservationAddBLoc>().add(
                                            ObservationAddEvent.create(
                                                Observation(
                                                    name:
                                                        state.nameObservation!,
                                                    time: state.time ??
                                                        DateTime.now(),
                                                    review: state.description),
                                                widget.hike));
                                      }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 50.w, vertical: 10.h),
                                        alignment: Alignment.center,
                                        height: 40.h,
                                        width: 0.7.sw,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: AppColor.blueIII),
                                        child: Text('Save',
                                            style: AppTypography.headline1
                                                .copyWith(
                                                    fontSize: 18.sp,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                  )
                                ],
                              ),
                            ),
                          )))
            ],
          )),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (newSelectedDate != null) {
      // ignore: use_build_context_synchronously
      context
          .read<ObservationAddBLoc>()
          .add(ObservationAddEvent.timeChanged(newSelectedDate));
      _selectedDate = newSelectedDate;
      timeObsTextController
        ..text = DateFormat.yMMMMd().format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: timeObsTextController.text.length,
            affinity: TextAffinity.downstream));
    } else {
      timeObsTextController.text = '';
    }
  }
}
