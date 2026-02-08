import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  int _locationToIndex(String location) {
    if (location.startsWith('/app/search')) return 1;
    if (location.startsWith('/app/favorites')) return 2;
    if (location.startsWith('/app/profile')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _locationToIndex(location);

    return FBottomNavigationBar(
      safeAreaBottom: true,
      index: index,
      onChange: (i) {
        switch (i) {
          case 0:
            context.go('/app/home');
            break;
          case 1:
            context.push('/app/search');
            break;
          case 2:
            context.push('/app/favorites');
            break;
          case 3:
            context.push('/app/profile');
            break;
        }
      },
      children: [
        FBottomNavigationBarItem(
          icon: Icon(index == 0 ? Icons.home_rounded : Icons.home_outlined),
          label: Text('Início'),
        ),
        FBottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: Text('Buscar'),
        ),
        FBottomNavigationBarItem(
          icon: Icon(
            index == 2
                ? Icons.favorite_outlined
                : Icons.favorite_outline_rounded,
          ),
          label: Text('Favoritos'),
        ),
        FBottomNavigationBarItem(
          icon: Icon(
            index == 3 ? Icons.person_rounded : Icons.person_outline_rounded,
          ),
          label: Text('Perfil'),
        ),
      ],
    );
  }
}
