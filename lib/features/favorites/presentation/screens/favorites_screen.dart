import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/shared/models/business.dart';
import 'package:ibivibe/features/businesses/presentation/controllers/businesses_controller.dart';
import 'package:ibivibe/features/businesses/presentation/widgets/business_card.dart';
import 'package:ibivibe/shared/models/city.dart';
import 'package:ibivibe/features/cities/presentation/controllers/cities_controller.dart';
import 'package:ibivibe/features/cities/presentation/widgets/city_card.dart';
import 'package:ibivibe/shared/models/event.dart';
import 'package:ibivibe/features/events/presentation/controllers/events_controller.dart';
import 'package:ibivibe/features/favorites/presentation/providers/favorites_state_provider.dart';
import 'package:ibivibe/shared/ui/fragments/events/event_card.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  bool _hasFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFetched) {
      _hasFetched = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _fetchFavoritedEntities();
      });
    }
  }

  void _fetchFavoritedEntities() {
    final favorites = ref.read(favoritesStateProvider).favorites;
    final citiesNotifier = ref.read(citiesProvider.notifier);
    final eventsNotifier = ref.read(eventsProvider.notifier);

    for (final fav in favorites) {
      if (fav.cityId != null) {
        citiesNotifier.getCityById(fav.cityId!);
      } else if (fav.eventId != null) {
        eventsNotifier.getEventById(fav.eventId!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesStateProvider).favorites;
    final citiesState = ref.watch(citiesProvider);
    final businessesState = ref.watch(businessesProvider);
    final eventsState = ref.watch(eventsProvider);

    final cityIds = favorites
        .where((f) => f.cityId != null)
        .map((f) => f.cityId!)
        .toSet();
    final businessIds = favorites
        .where((f) => f.businessId != null)
        .map((f) => f.businessId!)
        .toSet();
    final eventIds = favorites
        .where((f) => f.eventId != null)
        .map((f) => f.eventId!)
        .toSet();

    final cities = citiesState.maybeWhen(
      data: (list) => list.where((city) => cityIds.contains(city.id)).toList(),
      orElse: () => <City>[],
    );

    final businesses = businessesState.maybeWhen(
      data: (list) =>
          list.where((business) => businessIds.contains(business.id)).toList(),
      orElse: () => <Business>[],
    );

    final events = eventsState.maybeWhen(
      data: (list) =>
          list.where((event) => eventIds.contains(event.id)).toList(),
      orElse: () => <Event>[],
    );

    return FScaffold(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Text(
              'Favoritos',
              style: context.theme.typography.lg.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: FTabs(
                children: [
                  FTabEntry(
                    label: const Text('Cidades'),
                    child: _buildCityTab(citiesState, cities),
                  ),
                  FTabEntry(
                    label: const Text('Empresas'),
                    child: _buildBusinessTab(businessesState, businesses),
                  ),
                  FTabEntry(
                    label: const Text('Eventos'),
                    child: _buildEventTab(eventsState, events),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityTab(AsyncValue<List<City>> state, List<City> cities) {
    return state.maybeWhen(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Erro: $error')),
      orElse: () => cities.isNotEmpty
          ? ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cities.length,
              itemBuilder: (context, index) => CityCard(city: cities[index]),
              separatorBuilder: (_, _) => const SizedBox(height: 16),
            )
          : const _EmptyState(title: 'Nenhuma cidade favoritada ainda.'),
    );
  }

  Widget _buildBusinessTab(
    AsyncValue<List<Business>> state,
    List<Business> businesses,
  ) {
    return state.maybeWhen(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Erro: $error')),
      orElse: () => businesses.isNotEmpty
          ? ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: businesses.length,
              itemBuilder: (context, index) =>
                  BusinessCard(business: businesses[index]),
              separatorBuilder: (_, _) => const SizedBox(height: 16),
            )
          : const _EmptyState(title: 'Nenhuma empresa favoritada ainda.'),
    );
  }

  Widget _buildEventTab(AsyncValue<List<Event>> state, List<Event> events) {
    return state.maybeWhen(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Erro: $error')),
      orElse: () => events.isNotEmpty
          ? ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (context, index) => EventCard(event: events[index]),
              separatorBuilder: (_, _) => const SizedBox(height: 16),
            )
          : const _EmptyState(title: 'Nenhum evento favoritado ainda.'),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: context.theme.typography.sm.copyWith(
          color: context.theme.colors.mutedForeground,
        ),
      ),
    );
  }
}
