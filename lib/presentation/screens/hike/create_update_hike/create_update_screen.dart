// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:m_hike/common/constants.dart/constants.dart';
import 'package:m_hike/common/utils.dart';
import 'package:m_hike/domain/models/hike.dart';
import 'package:m_hike/presentation/routes/app_router.dart';
import 'package:m_hike/presentation/screens/hike/create_update/bloc/form/create_update_form_bloc.dart';
import 'package:m_hike/presentation/screens/hike/views/app_bar.dart';
import 'package:m_hike/presentation/views/textfield_view.dart';

@RoutePage()
class CreateUpdateHikeScreen extends StatefulWidget {
  const CreateUpdateHikeScreen({super.key, this.hike});
  final Hike? hike;

  @override
  State<CreateUpdateHikeScreen> createState() => _CreateUpdateHikeScreenState();
}

class _CreateUpdateHikeScreenState extends State<CreateUpdateHikeScreen> {
  Hike? get hike => widget.hike;

  late TextEditingController nameTextEditController;

  late TextEditingController locationTextEditController;

  late TextEditingController startDateTextEditController;

  late TextEditingController distanceTextEditController;

  late TextEditingController descriptionTextEditController;

  late TextEditingController completerTimeTextEditController;
  @override
  void initState() {
    nameTextEditController = TextEditingController(text: hike?.routerName);
    locationTextEditController =
        TextEditingController(text: hike?.destinationName);
    startDateTextEditController =
        TextEditingController(text: Util.formatDateTime(hike?.startTime));
    distanceTextEditController =
        TextEditingController(text: hike?.totalDuration.toString());
    descriptionTextEditController =
        TextEditingController(text: hike?.description);
    completerTimeTextEditController = TextEditingController();
    context.read<CreateUpdateFormBloc>().add(CreateUpdateHikeFormEvent.init(
        nameHike: hike?.routerName,
        locationHike: hike?.destinationName,
        startDate: hike?.startTime,
        distanceHike: hike?.totalDuration,
        description: hike?.description,
        isParking: hike?.isParkingRouter ?? false,
        levelDifficult: hike?.levelDifficultRouter,
        imagesPath: hike?.images));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateUpdateFormBloc, CreateUpdateHikeFormState>(
        builder: (_, state) => _Form(
              widget: widget,
              state: state,
              nameTextEditController: nameTextEditController,
              locationTextEditController: locationTextEditController,
              startDateTextEditController: startDateTextEditController,
              distanceTextEditController: distanceTextEditController,
              descriptionTextEditController: descriptionTextEditController,
              completerTimeTextEditController: completerTimeTextEditController,
            ));
  }
}

class _Form extends StatelessWidget {
  _Form(
      {Key? key,
      required this.widget,
      required this.state,
      required TextEditingController nameTextEditController,
      required TextEditingController locationTextEditController,
      required TextEditingController startDateTextEditController,
      required TextEditingController distanceTextEditController,
      required TextEditingController descriptionTextEditController,
      required TextEditingController completerTimeTextEditController})
      : _nameTextEditController = nameTextEditController,
        _locationTextEditController = locationTextEditController,
        _startDateTextEditController = startDateTextEditController,
        _distanceTextEditController = distanceTextEditController,
        _descriptionTextEditController = descriptionTextEditController,
        _completerTimeTextEditController = completerTimeTextEditController,
        super(key: key);

  final TextEditingController _nameTextEditController;
  final TextEditingController _locationTextEditController;
  final TextEditingController _startDateTextEditController;
  final TextEditingController _distanceTextEditController;
  final TextEditingController _descriptionTextEditController;
  final TextEditingController _completerTimeTextEditController;
  final CreateUpdateHikeScreen widget;
  final CreateUpdateHikeFormState state;

  FocusNode nameFocusNode = FocusNode();
  FocusNode locationFocusNode = FocusNode();
  FocusNode completerTimeFocusNode = FocusNode();
  FocusNode startDateFocusNode = FocusNode();
  FocusNode distanceFocusNode = FocusNode();

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _boxBottomNavigationBar(context, state),
        backgroundColor: Colors.white,
        appBar: const AppBarCreateUpdateView(),
        body: SafeArea(
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(30.h),
                              Text(
                                AppString.create_a_hike,
                                style: AppTypography.title.copyWith(
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Gap(30.h),
                              _componentViewField(
                                AppString.name_hike,
                                placeholder: AppString.enter_name_of_hike,
                                suffix: Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: SvgPicture.asset(
                                        height: 20.h,
                                        width: 20.h,
                                        AppImage.name,
                                        fit: BoxFit.cover)),
                                controller: _nameTextEditController,
                                onChanged: (text) => context
                                    .read<CreateUpdateFormBloc>()
                                    .add(CreateUpdateHikeFormEvent.nameChanged(
                                        text)),
                              ),
                              Gap(25.h),
                              _componentViewField(
                                AppString.location_hike,
                                controller: _locationTextEditController,
                                suffix: Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: SvgPicture.asset(
                                        height: 20.h,
                                        width: 20.h,
                                        AppImage.location,
                                        fit: BoxFit.cover)),
                                placeholder: AppString.enter_location_of_hike,
                                onChanged: (text) => context
                                    .read<CreateUpdateFormBloc>()
                                    .add(CreateUpdateHikeFormEvent
                                        .locationChanged(text)),
                              ),
                              Gap(25.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: 0.35.sw,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(AppString.startDate_hike,
                                                style: AppTypography.title
                                                    .copyWith(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                            Gap(10.h),
                                            TextField(
                                                controller:
                                                    _startDateTextEditController,
                                                focusNode:
                                                    AlwaysDisabledFocusNode(),
                                                decoration: InputDecoration(
                                                    hintText: AppString
                                                        .choose_date_start_hike,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w,
                                                            vertical: 5.h),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20.r),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColor
                                                                    .grayI)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20.r),
                                                        borderSide:
                                                            const BorderSide(color: AppColor.blueI)),
                                                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: const BorderSide(color: AppColor.redI))),
                                                onTap: () async {
                                                  await _selectDate(context);
                                                }),
                                            Gap(25.h),
                                            _checkBoxParkingView(
                                                context,
                                                state.isParking,
                                                !state.isParking)
                                          ])),
                                  Container(
                                      margin: EdgeInsets.only(right: 40.r),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(AppString.distance_hike,
                                                style: AppTypography.title
                                                    .copyWith(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                            Gap(10.h),
                                            SizedBox(
                                                width: 0.35.sw,
                                                child: TextFieldView(
                                                    suffix: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10.w),
                                                        child: const Text(
                                                          '.km',
                                                          style: TextStyle(
                                                              color: AppColor
                                                                  .grayIII),
                                                        )),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller:
                                                        _distanceTextEditController,
                                                    onChanged: (value) => context
                                                        .read<
                                                            CreateUpdateFormBloc>()
                                                        .add(CreateUpdateHikeFormEvent
                                                            .distanceHikeChanged(
                                                                double.parse(
                                                                    value))),
                                                    onSubmitted: (value) {}))
                                          ])),
                                ],
                              ),
                              Gap(15.h),
                              _buttonLevelDifficult(context),
                              Gap(15.h),
                              Text('Description',
                                  style: AppTypography.title.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600)),
                              Gap(10.h),
                              TextFormField(
                                maxLines: 7,
                                controller: _descriptionTextEditController,
                                decoration: InputDecoration(
                                    hintText: 'Enter description about hike',
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
                                    .read<CreateUpdateFormBloc>()
                                    .add(CreateUpdateHikeFormEvent
                                        .descriptionChanged(value)),
                              ),
                              Gap(15.h),
                              _imageHike(context),
                              GridView.builder(
                                  itemCount: state.imagesPath.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  itemBuilder: (context, index) => Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 5.h),
                                      child: Image.memory(
                                          Uint8List.fromList(
                                              state.imagesPath[index].image ??
                                                  []),
                                          fit: BoxFit.contain)))
                            ]))))));
  }

  Widget _completerTimeView() => TextField(
        controller: _completerTimeTextEditController,
        focusNode: completerTimeFocusNode,
      );

  Widget _checkBoxParkingView(
      BuildContext context, bool isAvailable, bool isUnAvailable) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(AppString.parking_available, style: AppTypography.title),
      Gap(10.h),
      GestureDetector(
          onTap: () => context
              .read<CreateUpdateFormBloc>()
              .add(const CreateUpdateHikeFormEvent.isParkingChanged(1)),
          child: _checkBoxView(isAvailable, AppString.available)),
      Gap(10.h),
      GestureDetector(
          onTap: () => context
              .read<CreateUpdateFormBloc>()
              .add(const CreateUpdateHikeFormEvent.isParkingChanged(2)),
          child: _checkBoxView(isUnAvailable, AppString.unavailable))
    ]);
  }

  Widget _checkBoxView(bool isAvailable, String text) {
    return Row(children: [
      isAvailable
          ? Container(
              height: 25.h,
              width: 25.h,
              decoration: BoxDecoration(
                color: AppColor.blueI,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: SvgPicture.asset(
                AppImage.tick_icon,
                color: Colors.white,
              ))
          : Container(
              height: 25.r,
              width: 25.r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(color: AppColor.grayI))),
      Gap(15.h),
      Text(text, style: AppTypography.title)
    ]);
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
          .read<CreateUpdateFormBloc>()
          .add(CreateUpdateHikeFormEvent.startDateChanged(newSelectedDate));
      _selectedDate = newSelectedDate;
      _startDateTextEditController
        ..text = DateFormat.yMMMMd().format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _startDateTextEditController.text.length,
            affinity: TextAffinity.downstream));
    } else {
      _startDateTextEditController.text = '';
    }
  }

  Widget _componentViewField(String title,
      {required TextEditingController controller,
      FocusNode? focusNode,
      Widget? suffix,
      String? placeholder,
      Function(String)? onChanged,
      Function(String)? onSubmitted}) {
    return Container(
      margin: EdgeInsets.only(right: 40.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: AppTypography.title
                .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600)),
        Gap(10.h),
        TextFieldView(
            suffix: suffix,
            placeholder: placeholder,
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            onSubmitted: onSubmitted)
      ]),
    );
  }

  Widget _buttonLevelDifficult(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        AppString.level_of_difficult,
        style: AppTypography.title.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      Gap(10.h),
      CustomSlidingSegmentedControl<int>(
          fixedWidth: 100.w,
          initialValue: 2,
          thumbDecoration: BoxDecoration(
              color: AppColor.blueIII,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 3.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0.0, 1.0))
              ]),
          decoration: BoxDecoration(
            color: AppColor.blueII,
            borderRadius: BorderRadius.circular(20.r),
          ),
          children: {
            1: Text(AppString.easy,
                style: AppTypography.title.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                textAlign: TextAlign.justify),
            2: Text(AppString.normal,
                style: AppTypography.title.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            3: Text(AppString.difficult,
                style: AppTypography.title.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          },
          onValueChanged: (int value) => context
              .read<CreateUpdateFormBloc>()
              .add(CreateUpdateHikeFormEvent.levelDifficultChanged(value)))
    ]);
  }

  Widget _boxBottomNavigationBar(
          BuildContext context, CreateUpdateHikeFormState state) =>
      Container(
          color: Colors.white,
          height: 70.h,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (state.isEmptyName) {
                      Util.showFail('Please enter name of your hike');
                    } else if (state.isEmptyLocation) {
                      Util.showFail(
                          'Please enter destination name for your hike');
                    } else if (state.isEmptyDistanceHike) {
                      Util.showFail(
                          'Please enter total distance for your hike');
                    } else if (state.isEmptyStartDate) {
                      Util.showFail('Please choos date for your hike');
                    } else {
                      context.router.push(HikeDetailRoute(
                          hike: Hike(
                              routerName: state.nameHike,
                              destinationName: state.locationHike,
                              created: DateTime.now(),
                              description: state.description,
                              levelDifficultRouter: state.levelDifficult,
                              isParkingRouter: state.isParking,
                              startTime: state.startDate,
                              images: state.imagesPath,
                              totalDuration: state.distanceHike),
                          isCreate: true));
                    }
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 10.h),
                      alignment: Alignment.center,
                      height: 40.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColor.blueIII),
                      child: Text(AppString.done,
                          style: AppTypography.headline1
                              .copyWith(fontSize: 18.sp, color: Colors.white))),
                )
              ]));

  Widget _imageHike(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.image,
          style: AppTypography.title.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(10.h),
        GestureDetector(
          onTap: () => showOptions(context),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              width: 200.w,
              height: 50.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  color: AppColor.blueIII),
              child: Row(children: [
                Image.asset(AppImage.camera, height: 35.h),
                Gap(10.w),
                Text('Add Image',
                    style: AppTypography.headline2.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600))
              ])),
        ),
      ],
    );
  }
}

Future showOptions(BuildContext context) async {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: const Text('Photo Gallery'),
          onPressed: () {
            Navigator.of(context).pop();
            context
                .read<CreateUpdateFormBloc>()
                .add(const CreateUpdateHikeFormEvent.imagesPathChanged(false));
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Camera'),
          onPressed: () {
            Navigator.of(context).pop();
            context
                .read<CreateUpdateFormBloc>()
                .add(const CreateUpdateHikeFormEvent.imagesPathChanged(true));
          },
        ),
      ],
    ),
  );
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
