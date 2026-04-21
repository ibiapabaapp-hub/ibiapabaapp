import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'profile_choose_screen.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingProfileScreen(
      onProfileSelected: (type) {
        if (type == ProfileType.user) {
          context.push('/app/interests/businesses');
        } else {
          context.push('/app/businesses/basic-data');
        }
      },
    );
  }
}
