import 'package:flutter/material.dart';
import 'package:test2learn/data/notifiers.dart';
import 'package:test2learn/views/pages/home_page.dart';
import 'package:test2learn/views/pages/location_page.dart';
import 'package:test2learn/widgets/navbar_widget.dart';

List<Widget> pages = [
  HomePage(),
  LocationPage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simple Weather App',
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(valueListenable: pageNotifier, builder: (context, selectedPage, child) {
        return pages.elementAt(selectedPage);
      }),
      bottomNavigationBar: NavbarWidget(),
    );
  }

}

