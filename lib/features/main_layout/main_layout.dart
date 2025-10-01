import 'package:evently_hti_sun/core/resources/routes_manager.dart';
import 'package:evently_hti_sun/features/main_layout/favourite/favourite_tab.dart';
import 'package:evently_hti_sun/features/main_layout/home/home_tab.dart';
import 'package:evently_hti_sun/features/main_layout/map/map_tab.dart';
import 'package:evently_hti_sun/features/main_layout/map/provider/map_tab_provider.dart';
import 'package:evently_hti_sun/features/main_layout/profile/profile_tab.dart';
import 'package:evently_hti_sun/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  List<Widget> tabs = [
    HomeTab(),
    ChangeNotifierProvider(
      create: (context) => MapTabProvider(),
      child: MapTab(),
    ),
    FavouriteTab(),
    ProfileTab(),
  ];

  int selectedIndex = 0;
  AppLocalizations? appLocalizations;

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(),
      body: tabs[selectedIndex],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, RoutesManager.createEvent);
      },
      child: Icon(Icons.add),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      notchMargin: 8,
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 0 ? Icons.home : Icons.home_outlined),
            label: appLocalizations!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 1
                  ? Icons.location_on
                  : Icons.location_on_outlined,
            ),
            label: appLocalizations!.map,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 2
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
            ),
            label: appLocalizations!.favourite,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 3 ? Icons.person : Icons.person_2_outlined,
            ),
            label: appLocalizations!.profile,
          ),
        ],
      ),
    );
  }

  void _onTap(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
  }
}
