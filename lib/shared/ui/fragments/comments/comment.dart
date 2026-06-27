import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class CommentItem {
  final String userName;
  final String text;
  final double ratingGiven;

  CommentItem({
    required this.userName,
    required this.text,
    required this.ratingGiven,
  });
}

class Comment extends StatelessWidget {
  final CommentItem comment;

  const Comment({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: .circular(8),
        color: context.theme.colors.secondary,
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          _UserHeadline(
            userName: comment.userName,
            ratingGiven: comment.ratingGiven,
          ),
          const SizedBox(height: 6),
          Text(
            comment.text,
            style: context.theme.typography.sm.copyWith(fontWeight: .w400),
          ),
        ],
      ),
    );
  }
}

class _UserHeadline extends StatelessWidget {
  final String userName;
  final double ratingGiven;

  const _UserHeadline({required this.userName, required this.ratingGiven});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Row(
          mainAxisAlignment: .start,
          spacing: 4,
          children: [
            // Container( // foto de perfil
            //   width: 20,
            //   height: 20,
            //   decoration: ShapeDecoration(
            //     color: context.theme.colors.background,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //   ),
            // ),
            Text(
              userName,
              style: context.theme.typography.sm.copyWith(fontWeight: .w600),
            ),
          ],
        ),
        _StarsGiven(ratingGiven: ratingGiven),
      ],
    );
  }
}

class _StarsGiven extends StatelessWidget {
  final double ratingGiven;

  const _StarsGiven({required this.ratingGiven});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      mainAxisAlignment: .center,
      children: [
        Text(
          ratingGiven.toStringAsFixed(1),
          style: context.theme.typography.xs.copyWith(fontWeight: .w400),
        ),
        Icon(
          Icons.star,
          size: 12,
          color: ratingGiven == 5
              ? context.theme.colors.primary
              : context.theme.colors.foreground,
        ),
      ],
    );
  }
}
