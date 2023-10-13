import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/library.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:m_hike/common/constants.dart/constants.dart';
import 'package:m_hike/presentation/screens/home/views/app_bar.dart';
import 'package:m_hike/presentation/views/textfield_view.dart';
import 'package:m_hike/presentation/widget/ellipsis_text.dart';

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
  Widget build(BuildContext context) {
    final Size fullSizeScreen = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const AppBarHomeView(),
        backgroundColor: Colors.white,
        body: Container(
            margin: const EdgeInsets.only(left: 15, right: 15, top: 25),
            width: fullSizeScreen.width,
            height: fullSizeScreen.height,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  height: fullSizeScreen.height * 0.16,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Let\'s see',
                            style: AppTypography.title.copyWith(fontSize: 26)),
                        Text('Your Hikes',
                            style:
                                AppTypography.headline2.copyWith(fontSize: 28)),
                        const Gap(20),
                        TextFieldView(
                            controller: _searchController,
                            placeholder: AppString.placeholer_search,
                            suffix: SvgPicture.asset(AppImage.search),
                            onChanged: (value) {},
                            onSubmitted: (value) {}),
                      ])),
              SizedBox(
                  height: fullSizeScreen.height * 0.693,
                  child: Column(children: [
                    CustomTabBar(
                        height: 40,
                        tabBarController: _tabBarController,
                        indicator: StandardIndicator(
                            radius: BorderRadius.circular(3.5),
                            width: 7,
                            height: 7,
                            color: Colors.black),
                        builder: (_, i) => TabBarItem(
                            index: i,
                            transform: ScaleTransform(
                                maxScale: 1.2,
                                builder: (_, scale) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
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
                    const Gap(10),
                    Flexible(
                        child: PageView.builder(
                            controller: _pageController,
                            itemCount: pageCount,
                            itemBuilder: (_, i) => ListView.separated(
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (_, index) => _itemHikeView(),
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Gap(10),
                                  itemCount: 6,
                                )))
                  ]))
            ])));
  }

  Widget _itemHikeView() {
    return Container(
        height: 135,
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.grayIII)),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              AppImage.default_image,
              fit: BoxFit.fill,
              height: double.infinity,
              width: 120,
            ),
          ),
          const Gap(10),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                EllipsisText(
                    'Ta Xua Moutain View And Moc Chau Farm Qua Hay jiee',
                    style: AppTypography.title
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    maxLines: 2),
                Row(children: [
                  SvgPicture.asset(AppImage.location, height: 20),
                  const Gap(5),
                  Flexible(
                      child: EllipsisText(
                          'Huyện Bắc Yên, tỉnh Sơn La, Việt Nam',
                          style: AppTypography.title.copyWith(fontSize: 13)))
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        SvgPicture.asset(AppImage.time, height: 20),
                        const Gap(5),
                        EllipsisText('01/01/2023',
                            style: AppTypography.title.copyWith(fontSize: 12))
                      ]),
                      Row(children: [
                        SvgPicture.asset(AppImage.distance, height: 20),
                        EllipsisText('13.4 km',
                            style: AppTypography.title.copyWith(fontSize: 12))
                      ])
                    ])
              ]))
        ]));
  }
}
