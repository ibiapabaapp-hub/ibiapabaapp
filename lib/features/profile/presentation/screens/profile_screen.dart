import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/session_provider.dart';
import 'package:ibiapabaapp/shared/ui/layout/wrappers/main_wrapper.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(sessionProvider);
    return SafeArea(
      top: true,
      child: FScaffold(
        header: FHeader.nested(),
        child: SingleChildScrollView(
          child: MainWrapper(
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      spacing: 16,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: ShapeDecoration(
                            color: context.theme.colors.secondary,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: context.theme.colors.primary,
                              ),
                              borderRadius: .circular(50),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: .min,
                            mainAxisAlignment: .center,
                            crossAxisAlignment: .start,
                            spacing: 4,
                            children: [
                              Text(
                                user?.name ?? 'ET Bilu',
                                textAlign: .center,
                                overflow: .ellipsis,
                                style: TextStyle(
                                  color: context.theme.colors.foreground,
                                  fontSize: 16,
                                  fontWeight: .w500,
                                ),
                              ),
                              Text(
                                '@${user?.username ?? 'et_bilu'}',
                                textAlign: .center,
                                overflow: .ellipsis,
                                style: TextStyle(
                                  color: context.theme.colors.mutedForeground,
                                  fontSize: 16,
                                  fontWeight: .w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  FButton.icon(
                    style: FButtonStyle.secondary(),
                    onPress: () {},
                    child: Icon(
                      Icons.settings,
                      size: 24,
                      color: context.theme.colors.foreground,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
