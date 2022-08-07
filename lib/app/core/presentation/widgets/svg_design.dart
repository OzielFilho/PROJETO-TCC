import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors/colors_utils.dart';

class SvgDesign extends StatelessWidget {
  final String path;
  final Color? color;
  final double? height;
  final double? width;
  const SvgDesign(
      {Key? key, required this.path, this.color, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        path,
        height: height,
        width: width,
        color: color ?? ColorUtils.whiteColor,
      ),
    );
  }
}
