import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/shared/custom_appbar.dart';

class SavedScreen extends StatelessWidget {

  static const name = "saved-screen";

  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: const CustomAppbar(),
      ),
    );
  }
}