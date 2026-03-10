import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:skeletonizer/skeletonizer.dart';

ShimmerEffect customShimmerEffect(BuildContext context) {
  return ShimmerEffect(
    begin: .centerStart,
    baseColor: context.theme.colors.muted,
    highlightColor: context.theme.colors.muted.withAlpha(90),
    duration: Duration(milliseconds: 800),
  );
}
