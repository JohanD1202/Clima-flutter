import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Ingrese el nombre de la ciudad",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.lightBlue, width: 2)
                  ),
                  prefixIcon: const Icon(LucideIcons.search, color: Colors.black),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Icon(LucideIcons.refreshCcw, color: Colors.black)
          ],
        ),
      ),
    );
  }
}