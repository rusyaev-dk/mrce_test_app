import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: switch (Theme.of(context).platform) {
        TargetPlatform.iOS || TargetPlatform.macOS => CupertinoTabBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.map),
              label: 'Карта',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bookmark),
              label: 'Сохраненные',
            ),
          ],
        ),
        _ => NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.map_outlined),
              selectedIcon: Icon(Icons.map),
              label: 'Карта',
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark_border_rounded),
              selectedIcon: Icon(Icons.bookmark_rounded),
              label: 'Сохраненные',
            ),
          ],
        ),
      },
    );
  }
}
