import 'package:weather_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/saved',
      name: SavedScreen.name,
      builder: (context, state) => const SavedScreen(),
    ),
  ]
);