import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 700;
  }
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 700 &&
        MediaQuery.of(context).size.width < 1200;
  }
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(size.width < 700) {
      return mobile;
    } else if (size.width >= 700 && size.width < 1200) {
      return tablet ?? mobile;
    } else if (size.width >= 1200) {
      return desktop;
    }
    return const Placeholder();
  }
}
