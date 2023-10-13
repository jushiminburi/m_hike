import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:m_hike/common/constants.dart/app_typography.dart';

class AppBarHomeView extends StatefulWidget implements PreferredSizeWidget {
  const AppBarHomeView({super.key});

  @override
  State<AppBarHomeView> createState() => _AppBarHomeViewState();

  @override
  Size get preferredSize => const Size.fromHeight(55);
}

class _AppBarHomeViewState extends State<AppBarHomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const CircleAvatar(
                backgroundColor: Colors.amberAccent,
              ),
              const Gap(10),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning',
                      style: AppTypography.headline2,
                    ),
                    const Text(
                      '28 °C',
                      style: AppTypography.title,
                    ),
                  ])
            ])));
  }
}
