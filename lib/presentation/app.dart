import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigation/app_router.dart';
import 'providers/theme_provider.dart';
import 'theme/theme.dart';
import 'theme/colors.dart';

class VPPApp extends ConsumerWidget {
  const VPPApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final colorScheme = colorSchemes[themeState.colorSchemeIndex];

    return MaterialApp.router(
      title: 'Vitruvian Project Phoenix',
      theme: getAppTheme(lightColorScheme),
      darkTheme: getAppTheme(colorScheme),
      themeMode: themeState.brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
