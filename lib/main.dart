import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/config/config.dart';
import '/infrastructure/services/services.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(
      child: MainApp()
    )
  );
}

final themeNotifier = ThemeNotifier();
final appTheme = AppTheme();

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentMode = ref.watch(themeProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: appTheme.lightTheme(),
      darkTheme: appTheme.darkTheme(),
      themeMode: currentMode,
    );
  }
}


