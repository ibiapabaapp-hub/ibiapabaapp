import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixes: [
          Text(
            'Favoritos',
            style: context.theme.typography.lg.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Expanded(
              child: FTabs(
                children: [
                  FTabEntry(
                    label: const Text('Cidades'),
                    child: _EmptyState(
                      title: 'Nenhuma cidade favoritada ainda.',
                    ),
                  ),
                  FTabEntry(
                    label: const Text('Empresas'),
                    child: _EmptyState(
                      title: 'Nenhuma empresa favoritada ainda.',
                    ),
                  ),
                  FTabEntry(
                    label: const Text('Eventos'),
                    child: _EmptyState(
                      title: 'Nenhum evento favoritado ainda.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          title,
          style: context.theme.typography.sm.copyWith(
            color: context.theme.colors.mutedForeground,
          ),
        ),
      ),
    );
  }
}
