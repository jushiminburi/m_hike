import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'views/map_view.dart';

@RoutePage()
class HikingScreen extends StatefulWidget {
  const HikingScreen({super.key});

  @override
  State<HikingScreen> createState() => _HikingScreenState();
}

class _HikingScreenState extends State<HikingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              MapView(),
              DraggableScrollableSheet(
                  initialChildSize: 0.1,
                  minChildSize: 0.1,
                  maxChildSize: 0.3,
                  builder: (_, scroll) => ClipRRect(
                        borderRadius:  BorderRadiusDirectional.vertical(
                            top: Radius.circular(30.r)),
                        child: Container(
                          color: Colors.blueAccent,
                          child: ListView(
                            physics: ClampingScrollPhysics(),
                            controller: scroll,
                            children: [
                              Text('Total active time'),
                              Text('Total distance'),
                              Text('Total foot step')
                            ],
                          ),
                        ),
                      ))
            ],
          )),
    );
  }
}
