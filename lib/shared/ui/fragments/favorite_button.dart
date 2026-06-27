import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/shared/providers/accounts_state_provider.dart';
import 'package:ibiapabaapp/features/favorites/domain/entities/favorite.dart';
import 'package:ibiapabaapp/features/favorites/presentation/providers/favorites_state_provider.dart';

class FavoriteButton extends ConsumerStatefulWidget {
  final String? cityId;
  final String? businessId;
  final String? eventId;

  const FavoriteButton({
    super.key,
    this.cityId,
    this.businessId,
    this.eventId,
  });

  @override
  ConsumerState<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends ConsumerState<FavoriteButton> {
  bool _isLoading = false;

  bool _isFavorited(List<Favorite> favorites) {
    return favorites.any(
      (fav) =>
          (widget.cityId != null && fav.cityId == widget.cityId) ||
          (widget.eventId != null && fav.eventId == widget.eventId) ||
          (widget.businessId != null &&
              fav.businessId == widget.businessId),
    );
  }

  Favorite? _getFavorite(List<Favorite> favorites) {
    try {
      return favorites.firstWhere(
        (fav) =>
            (widget.cityId != null && fav.cityId == widget.cityId) ||
            (widget.eventId != null && fav.eventId == widget.eventId) ||
            (widget.businessId != null &&
                fav.businessId == widget.businessId),
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _toggleFavorite(
    bool isFavorited,
    Favorite? favorite,
    dynamic activeAccount,
  ) async {
    if (activeAccount == null || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      if (isFavorited && favorite != null) {
        await ref.read(favoritesStateProvider.notifier).popFavorite(favorite);
      } else {
        final newFavorite = Favorite(
          id: null,
          accountId: activeAccount.id,
          cityId: widget.cityId,
          eventId: widget.eventId,
          businessId: widget.businessId,
        );
        await ref
            .read(favoritesStateProvider.notifier)
            .pushFavorite(newFavorite);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesState = ref.watch(favoritesStateProvider);
    final activeAccount = ref.watch(accountsStateProvider).activeAccount;
    final isFavorited = _isFavorited(favoritesState.favorites);
    final favorite = _getFavorite(favoritesState.favorites);

    return FButton.icon(
      style: FButtonStyle.secondary(),
      onPress: _isLoading
          ? null
          : () => _toggleFavorite(isFavorited, favorite, activeAccount),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.bounceOut),
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: _isLoading
            ? const SizedBox(
                key: ValueKey('loading'),
                width: 24,
                height: 24,
                child: FCircularProgress(),
              )
            : Icon(
                isFavorited
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                key: ValueKey<bool>(isFavorited),
                size: 24,
                color: isFavorited
                    ? context.theme.colors.primary
                    : context.theme.colors.foreground,
              ),
      ),
    );
  }
}
