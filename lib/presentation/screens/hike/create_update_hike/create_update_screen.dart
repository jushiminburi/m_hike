// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:m_hike/common/constants.dart/constants.dart';
import 'package:m_hike/presentation/views/textfield_view.dart';

@RoutePage()
class CreateUpdateHikeScreen extends StatefulWidget {
  const CreateUpdateHikeScreen({super.key});

  @override
  State<CreateUpdateHikeScreen> createState() => _CreateUpdateHikeScreenState();
}

class _CreateUpdateHikeScreenState extends State<CreateUpdateHikeScreen> {
  TextEditingController nameTextEditController = TextEditingController();

  TextEditingController locationTextEditController = TextEditingController();

  TextEditingController startDateTextEditController = TextEditingController();
  TextEditingController distanceTextEditController = TextEditingController();
  TextEditingController completerTimeTextEditController =
      TextEditingController();
  FocusNode nameFocusNode = FocusNode();

  FocusNode locationFocusNode = FocusNode();
  FocusNode completerTimeFocusNode = FocusNode();
  FocusNode startDateFocusNode = FocusNode();
  FocusNode distanceFocusNode = FocusNode();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _boxBottomNavigationBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Gap(30),
              Text(
                AppString.create_a_hike,
                style: AppTypography.title
                    .copyWith(fontSize: 40, fontWeight: FontWeight.w700),
              ),
              const Gap(30),
              _componentViewField(AppString.name_hike,
                  placeholder: AppString.enter_name_of_hike,
                  suffix: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SvgPicture.asset(
                          // color: AppColor.grayIII,
                          height: 20,
                          width: 20,
                          AppImage.name,
                          fit: BoxFit.cover)),
                  controller: nameTextEditController,
                  focusNode: nameFocusNode),
              const Gap(25),
              _componentViewField(AppString.location_hike,
                  controller: locationTextEditController,
                  suffix: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SvgPicture.asset(
                          height: 20,
                          width: 20,
                          AppImage.location,
                          fit: BoxFit.cover)),
                  placeholder: AppString.enter_location_of_hike,
                  focusNode: locationFocusNode),
              const Gap(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 200,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppString.startDate_hike,
                                style: AppTypography.title.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const Gap(10),
                            TextField(
                                controller: startDateTextEditController,
                                focusNode: AlwaysDisabledFocusNode(),
                                decoration: InputDecoration(
                                    hintText: AppString.choose_date_start_hike,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: AppColor.grayI)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: AppColor.blueI)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: AppColor.redI))),
                                onTap: () async => await _selectDate(context)),
                            const Gap(25),
                            _checkBoxParkingView(),
                          ])),
                  Container(
                      margin: const EdgeInsets.only(right: 40),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppString.distance_hike,
                                style: AppTypography.title.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const Gap(10),
                            SizedBox(
                                width: 150,
                                child: TextFieldView(
                                    suffix: const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(
                                          '.km',
                                          style: TextStyle(
                                              color: AppColor.grayIII),
                                        )),
                                    keyboardType: TextInputType.number,
                                    controller: distanceTextEditController,
                                    focusNode: distanceFocusNode,
                                    onChanged: (value) {},
                                    onSubmitted: (value) {}))
                          ])),
                ],
              ),
              const Gap(15),
              _buttonLevelDifficult(),
              const Gap(15),
              _completerTimeView()
            ]),
          ),
        ),
      )),
    );
  }

  Widget _completerTimeView() => TextField(
        controller: completerTimeTextEditController,
        focusNode: completerTimeFocusNode,
      );

  Widget _checkBoxParkingView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppString.parking_available, style: AppTypography.title),
        const Gap(10),
        _checkBoxView(false, AppString.available),
        const Gap(10),
        _checkBoxView(true, AppString.unavailable),
      ],
    );
  }

  Widget _checkBoxView(bool isAvailable, String text) {
    return Row(children: [
      isAvailable
          ? Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: AppColor.blueI,
                borderRadius: BorderRadius.circular(5),
              ),
              child: SvgPicture.asset(
                AppImage.tick_icon,
                color: Colors.white,
              ))
          : Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColor.grayI))),
      const Gap(15),
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
      _selectedDate = newSelectedDate;
      startDateTextEditController
        ..text = DateFormat.yMMMMd().format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: startDateTextEditController.text.length,
            affinity: TextAffinity.downstream));
    } else {
      startDateTextEditController.text = '';
    }
  }

  Widget _componentViewField(String title,
      {required TextEditingController controller,
      required FocusNode focusNode,
      Widget? suffix,
      String? placeholder,
      Function(String)? onChanged,
      Function(String)? onSubmitted}) {
    return Container(
      margin: const EdgeInsets.only(right: 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: AppTypography.title
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
        const Gap(10),
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

  Widget _buttonLevelDifficult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.level_of_difficult,
          style: AppTypography.title.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(10),
        CustomSlidingSegmentedControl<int>(
          fixedWidth: 100,
          initialValue: 2,
          thumbDecoration: BoxDecoration(
            color: AppColor.blueIII,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 3.0,
                spreadRadius: 2.0,
                offset: const Offset(0.0, 1.0),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: AppColor.blueII,
            borderRadius: BorderRadius.circular(20),
          ),
          children: {
            1: Text(
              AppString.easy,
              style: AppTypography.title.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              textAlign: TextAlign.justify,
            ),
            2: Text(
              AppString.normal,
              style: AppTypography.title.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            3: Text(
              AppString.difficult,
              style: AppTypography.title.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          },
          onValueChanged: (int value) {
            print(value);
          },
        ),
      ],
    );
  }

  Widget _boxBottomNavigationBar() => Container(
      color: Colors.white,
      height: 70,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(color: Color(0xffDDE0EC)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                  alignment: Alignment.center,
                  width: 165,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.blueII),
                  child: Text(AppString.cancel,
                      style: AppTypography.headline1
                          .copyWith(fontSize: 15, color: Colors.white))),
              Container(
                  alignment: Alignment.center,
                  width: 165,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.blueIII),
                  child: Text(AppString.done,
                      style: AppTypography.headline1
                          .copyWith(fontSize: 15, color: Colors.white))),
            ])
          ]));
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
