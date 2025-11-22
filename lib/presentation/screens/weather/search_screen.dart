import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/presentation/widgets/widgets.dart';
import '/presentation/providers/providers.dart';

class SearchScreen extends StatelessWidget {
  static const name = "saved-screen";
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(95),
        child: CustomAppbar(),
      ),
      body: _BodySearchScreen()
    );
  }
}

class _BodySearchScreen extends ConsumerWidget {
  const _BodySearchScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coords = ref.watch(currentLocationProvider);

    if (coords == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final weatherAsync = ref.watch(weatherByLocationProvider(coords));

    return Column(
      children: [
        const SuggestionsList(),
        Expanded(
          child: WeatherList(weatherAsync: weatherAsync),
        ),
      ],
    );
  }
}