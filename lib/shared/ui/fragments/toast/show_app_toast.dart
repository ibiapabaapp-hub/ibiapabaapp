import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

void showAppToast({
  required BuildContext context,
  required String title,
  String? description,
  Widget? icon,
  FToastAlignment? alignment,
  Duration? duration = const Duration(seconds: 5),
}) {
  final navigator = Navigator.of(context, rootNavigator: true);

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!navigator.mounted) return;

    showRawFToast(
      context: context,
      alignment: alignment,
      duration: duration,
      swipeToDismiss: [AxisDirection.right, AxisDirection.down],
      builder: (context, entry) {
        final style = context.theme.toasterStyle.toastStyle;

        return ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: DecoratedBox(
            decoration: style.decoration,
            child: Padding(
              padding: style.padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    IconTheme(
                      data: style.iconStyle.copyWith(size: 20),
                      child: icon,
                    ),
                    SizedBox(width: style.iconSpacing),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 4,
                      children: [
                        Text(
                          title,
                          style: context.theme.typography.base.copyWith(
                            fontWeight: .w600,
                          ),
                        ),
                        description != null
                            ? Text(
                                description,
                                style: context.theme.typography.sm,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  SizedBox(width: style.suffixSpacing),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: entry.dismiss,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  });
}
