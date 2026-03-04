import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({super.key, required this.text});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = context.theme.typography.sm.copyWith(
      fontWeight: FontWeight.normal,
      color: context.theme.colors.foreground.withAlpha(isExpanded ? 255 : 172),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: widget.text, style: textStyle),
          maxLines: 3,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);
        final bool hasOverflow = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 350),
              curve: Curves.fastOutSlowIn,
              alignment: Alignment.topCenter,
              child: Text(
                widget.text,
                textAlign: TextAlign.start,
                overflow: isExpanded
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
                maxLines: isExpanded ? null : 3,
                style: textStyle,
              ),
            ),

            if (hasOverflow || isExpanded)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FButton(
                  style: FButtonStyle.ghost(),
                  onPress: () => setState(() => isExpanded = !isExpanded),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isExpanded ? 'Ver menos' : 'Ler mais',
                        style: TextStyle(
                          color: context.theme.colors.foreground,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: context.theme.colors.foreground,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
