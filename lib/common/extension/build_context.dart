import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 650;
  bool get isTablet =>
      MediaQuery.of(this).size.width < 1024 &&
      MediaQuery.of(this).size.width >= 650;
}

