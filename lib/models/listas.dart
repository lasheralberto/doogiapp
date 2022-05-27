import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

final List<String> items = [
  'Cuidados del perro',
  'Descanso de tu perro',
  'Paseos con tu perro'
];
final List<String> itemsComplement = [
  'Dogs, Veterinario',
  'Dogs, Sleep',
  'Dogs, Walk, Stroll'
];

final List<IconData> iconos = [
  Icons.moving_outlined,
  Icons.cloud_circle_sharp,
  Icons.event_available_rounded
];

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ("Home"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.settings),
      title: ("Settings"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}



