import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/shared/ui/fragments/rating/rating_input_sheet.dart';

class RatingSection extends StatefulWidget {
  final double averageRating;
  final int ratingQuantity;
  const RatingSection({
    super.key,
    required this.averageRating,
    required this.ratingQuantity,
  });

  @override
  State<RatingSection> createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Text(
          'Avaliações',
          style: TextStyle(
            color: context.theme.colors.foreground,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          spacing: 10,
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .center,
          children: [
            Row(
              spacing: 10,
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                Text(
                  widget.averageRating.toStringAsFixed(1),
                  style: TextStyle(
                    color: context.theme.colors.foreground,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                EasyStarsRating(
                  allowHalfRating: true,
                  initialRating: widget.averageRating,
                  readOnly: true,
                  maxRating: 5,
                  minRating: 0,
                  emptyColor: context.theme.colors.mutedForeground,
                  starSize: 20,
                  filledColor: context.theme.colors.primary,
                ),
                GestureDetector(
                  onTap: () => showFToast(
                    context: context,
                    title: Text(
                      'TODO: implementar redirecionamento para avaliações',
                      style: context.theme.typography.sm.copyWith(
                        color: context.theme.colors.foreground,
                      ),
                    ),
                  ),
                  child: Text(
                    "(${widget.ratingQuantity})",
                    style: TextStyle(
                      color: context.theme.colors.mutedForeground,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            FButton(
              style: FButtonStyle.secondary(),
              onPress: () {
                showRatingInputSheet(context: context);
              },
              child: Text('Avaliar', style: context.theme.typography.sm),
            ),
          ],
        ),
      ],
    );
  }
}

Future<ReviewData?> showRateSheet(BuildContext context) {
  return EasyStarsReviewBottomSheet.show(
    context: context,
    title: 'Avaliar empresa',
    subtitle: 'Conte-nos sobre sua experiência',
    initialRating: 0.0,
    reviewType: ReviewType.stars,
    allowModeSwitch: false,
    allowHalfRating: true,
    isCommentRequired: false,
    minCharacters: 10,
    maxCharacters: 300,
    showRatingLabels: false,
    animationConfig: StarAnimationConfig.bounce,
    filledColor: context.theme.colors.primary,
    emptyColor: context.theme.colors.mutedForeground,
    starCount: 5,
    ratingSize: 36.0,
    hintText: 'Compartilhe conosco seu ponto de vista',
  );
}
