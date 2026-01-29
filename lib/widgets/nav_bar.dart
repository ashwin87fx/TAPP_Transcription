import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/controllers/theme_controller.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.waves, color: Theme.of(context).primaryColor, size: 32),
              const SizedBox(width: 10),
              Text(
                "TAPP",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              _NavButton(title: "Home", route: "/"),
              _NavButton(title: "Studio", route: "/transcribe"),
              _NavButton(title: "About", route: "/about"),
              const SizedBox(width: 16),
              Obx(() {
                final controller = Get.find<ThemeController>();
                return IconButton(
                  onPressed: controller.toggleTheme,
                  icon: Icon(
                    controller.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String title;
  final String route;

  const _NavButton({required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    bool isActive = Get.currentRoute == route;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () {
          if (Get.currentRoute != route) {
            Get.toNamed(route);
          }
        },
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
