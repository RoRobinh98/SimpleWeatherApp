import 'package:flutter/material.dart';
import 'package:test2learn/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          selectedIndex: selectedPage,
          destinations: [
            NavigationDestination(icon: Icon(Icons.sunny), label: 'Weather'),
            NavigationDestination(icon: Icon(Icons.map), label: 'Location'),
          ],
          onDestinationSelected: (int value) {
            pageNotifier.value = value;
          },
        );
      },);
  }



}
