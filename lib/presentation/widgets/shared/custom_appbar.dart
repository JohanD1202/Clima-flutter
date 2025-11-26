import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '/infrastructure/services/services.dart';
import '/presentation/widgets/widgets.dart';
import '/presentation/providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final iconColor = Theme.of(context).iconTheme.color;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: SizedBox(
                    height: 50,
                    child: _TextField(),
                  ),
                ),
                const SizedBox(width: 5),
                IconButton(
                  icon: const Icon(LucideIcons.refreshCcw),
                  color: iconColor,
                  onPressed: () async {
                    ref.read(isRefreshingProvider.notifier).state = true;
                    await ref.read(searchedWeatherProvider.notifier).refresh(ref);
                    ref.read(isRefreshingProvider.notifier).state = false;
                  },
                ),
                IconButton(
                  icon: const Icon(LucideIcons.trash2),
                  color: iconColor,
                  onPressed: () {

                    final list = ref.read(searchedWeatherProvider);
                    final textTheme = Theme.of(context);
                    final backgroundTheme = Theme.of(context).scaffoldBackgroundColor;

                    if(list.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: LocalizedText(
                            translations: const {
                              "es": "No hay ciudades para borrar",
                              "en": "There are no cities to delete"
                            },
                            style: textTheme.textTheme.bodyLarge,
                          ),
                          backgroundColor: backgroundTheme,
                        ),
                      );
                      return;
                    }
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const _AlertDialog();
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertDialog extends ConsumerWidget {
  const _AlertDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textTheme = Theme.of(context).textTheme;
    final backgroundTheme = Theme.of(context).scaffoldBackgroundColor;

    return AlertDialog(
      backgroundColor: backgroundTheme,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: LocalizedText(
        translations: const {
          "es": "¿Borrar todas las ciudades?",
          "en": "Delete all cities?"
        },
        style: textTheme.titleLarge,
      ),
      content: LocalizedText(
        translations: const {
          "es": "Esta acción eliminará toda la lista de resultados",
          "en": "This action will remove the entire results list"
        },
        style: textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: LocalizedText(
            translations: const {
              "es": "Cancelar",
              "en": "Cancel"
            },
            style: textTheme.bodyMedium,
          ),
        ),
        TextButton(
          onPressed: () {
            ref.read(searchedWeatherProvider.notifier).clear();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: LocalizedText(
                  translations: const {
                    "es": "Las ciudades se eliminaron correctamente",
                    "en": "The cities were removed correctly"
                  },
                  style: textTheme.bodyLarge,
                ),
                backgroundColor: backgroundTheme,
              ),
            );
          },
          child: LocalizedText(
            translations: const {
              "es": "Borrar",
              "en": "Delete"
            },
              style: textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
class _TextField extends ConsumerWidget {
  const _TextField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final lang = ref.watch(languageProvider);
    final hint = {
      "es": "Ingrese el nombre de la ciudad",
      "en": "Enter the city name",
    }[lang] ?? "Enter the city name";
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final hintColor = Theme.of(context).hintColor;
    final iconColor = Theme.of(context).iconTheme.color;

    final theme = Theme.of(context);
    final fillColor = theme.colorScheme.surface;

    return TextField(
      onChanged: (value) {
        ref.read(searchQueryProvider.notifier).state = value;
      },
      style: TextStyle(color: textColor),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hint,
        hintStyle: TextStyle(color: hintColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          LucideIcons.search,
          color: iconColor,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}
