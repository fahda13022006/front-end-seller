import 'package:flutter/material.dart';

class AppResponsive {
  AppResponsive._();

  static const double mobile = 600;
  static const double desktop = 1000;
  static const double maxContentWidth = 1400;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobile;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= desktop;

  static EdgeInsets pagePadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < mobile) {
      return const EdgeInsets.fromLTRB(16, 12, 16, 24);
    }
    if (width < desktop) {
      return const EdgeInsets.fromLTRB(20, 16, 20, 28);
    }
    return const EdgeInsets.fromLTRB(24, 18, 24, 32);
  }

  static double sectionGap(BuildContext context) =>
      isMobile(context) ? 20 : 24;

  static double cardRadius(BuildContext context) =>
      isMobile(context) ? 18 : 20;
}
