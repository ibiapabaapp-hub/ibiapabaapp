import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

void showAppToast({
  required BuildContext context,
  required Widget title,
  Widget? icon,
  Widget? description,
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
                    IconTheme(data: style.iconStyle, child: icon),
                    SizedBox(width: style.iconSpacing),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DefaultTextStyle(
                          style: style.titleTextStyle,
                          maxLines: 100,
                          child: title,
                        ),
                        if (description != null) ...[
                          SizedBox(height: style.titleSpacing),
                          DefaultTextStyle(
                            style: style.descriptionTextStyle,
                            maxLines: 100,
                            child: description,
                          ),
                        ],
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
