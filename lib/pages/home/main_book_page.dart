import 'package:ebook/widgets/DogsAdoptionAll.dart';
import 'package:ebook/widgets/DogsAdoptionList.dart';
import 'package:ebook/widgets/MainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:location/location.dart';

class MainBookPage extends StatefulWidget {
  var userEmail;
  MainBookPage({Key? key, required this.userEmail}) : super(key: key);
  @override
  _MainBookPageState createState() => _MainBookPageState();
}

class _MainBookPageState extends State<MainBookPage> {
  final _controller = PersistentTabController(initialIndex: 0);
  Location location = Location();
  GeoCode geoCode = GeoCode();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  var fieldLatitude;
  var fieldLogitude;
  var addressCity;

  Future<void> getfieldlocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();

    setState(() {
      fieldLatitude = _locationData.latitude;
      fieldLogitude = _locationData.longitude;
    });
  }

  @override
  void initState() {
    super.initState();
    getfieldlocation();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        border: Border.all(color: const Color.fromARGB(255, 95, 126, 141)),
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style9,
      controller: _controller,
      screens: [
        const MainPage(),
        DogsAdoptionAll(lat: fieldLatitude, long: fieldLogitude, mail: widget.userEmail),
        DogsAdoptionList(
          lat: fieldLatitude,
          long: fieldLogitude,
          usermail: widget.userEmail,
         
        ),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.list_number),
          title: ("Adopt"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.heart_circle_fill),
          title: ("My Dogs"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ],
    );
  }
}
