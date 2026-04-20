import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/shared/ui/fragments/comments/comment.dart';
import 'package:ibiapabaapp/shared/ui/fragments/toast/show_app_toast.dart';

class CommentList extends StatelessWidget {
  final List<CommentItem> comments;
  const CommentList({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 14,
      children: [
        ...comments.map((item) => Comment(comment: item)),
        FButton.raw(
          style: FButtonStyle.ghost(),
          onPress: () {
            showAppToast(
              context: context,
              title: Text(
                'TODO: página com todos os comentários',
                style: context.theme.typography.sm,
              ),
            );
          },
          child: Text(
            'Ver todos os comentários',
            style: context.theme.typography.sm,
          ),
        ),
      ],
    );
  }
}
