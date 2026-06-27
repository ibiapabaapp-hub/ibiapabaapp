import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:skeletonizer/skeletonizer.dart';

typedef CarouselItemBuilder<T> = Widget Function(BuildContext context, T item);

class HorizontalInfiniteCarousel<T> extends StatefulWidget {
  final bool showProgressBar;
  final List<T> items;
  final CarouselItemBuilder<T> itemBuilder;
  final double? itemWidth;
  final double listHeight;
  final Widget separator;
  final bool isLoading;

  const HorizontalInfiniteCarousel({
    super.key,
    required this.isLoading,
    required this.items,
    required this.listHeight,
    required this.separator,
    this.itemWidth,
    required this.itemBuilder,
    this.showProgressBar = true,
  });

  @override
  State<HorizontalInfiniteCarousel<T>> createState() =>
      _HorizontalInfiniteCarouselState<T>();
}

class _HorizontalInfiniteCarouselState<T>
    extends State<HorizontalInfiniteCarousel<T>> {
  double _progress = 0.0;
  bool _showIndicator = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkIfCanScroll());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _checkIfCanScroll() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final canScroll = maxScroll > 0;

      if (_showIndicator != canScroll) {
        setState(() {
          _showIndicator = canScroll;
        });
      }
    }
  }

  void _updateProgress(ScrollMetrics metrics) {
    final canScroll = metrics.maxScrollExtent > 0;
    final progress = (metrics.pixels / metrics.maxScrollExtent).clamp(0.0, 1.0);

    if (_showIndicator != canScroll || _progress != progress) {
      setState(() {
        _showIndicator = canScroll;
        _progress = progress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Skeletonizer(
          effect: customShimmerEffect(context),
          enabled: widget.isLoading,
          child: SizedBox(
            height: widget.listHeight,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                _updateProgress(notification.metrics);
                return false;
              },
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                clipBehavior: Clip.none,
                itemCount: widget.items.length,
                separatorBuilder: (_, _) => widget.separator,
                itemBuilder: (context, index) {
                  final child = widget.itemBuilder(
                    context,
                    widget.items[index],
                  );
                  if (widget.itemWidth == null) return child;
                  return SizedBox(width: widget.itemWidth, child: child);
                },
              ),
            ),
          ),
        ),

        if (!widget.isLoading && _showIndicator && widget.showProgressBar) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildProgressBar(),
          ),
        ],
      ],
    );
  }

  Widget _buildProgressBar() {
    return Container(
      width: double.infinity,
      height: 4,
      decoration: BoxDecoration(
        color: context.theme.colors.secondary,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 50),
                width:
                    constraints.maxWidth * 0.1 +
                    (constraints.maxWidth * 0.9 * _progress),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.theme.colors.foreground.withAlpha(
                      (255 / 4).toInt(),
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
