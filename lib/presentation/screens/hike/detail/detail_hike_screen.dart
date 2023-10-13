import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_hike/common/constants.dart/constants.dart';

@RoutePage()
class HikeDetailScreen extends StatefulWidget {
  const HikeDetailScreen({super.key});

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
            AppImage.default_cover,
            height: size.height * 0.3,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: 1,
            child: Container(
              width: size.width,
              height: size.height * 0.75,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadiusDirectional.vertical(
                      top: Radius.circular(30))),
            ),
          )
        ]),
      ),
    );
  }
}
