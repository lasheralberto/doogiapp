import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/pages/home/book_body.dart';
import 'package:ebook/utils/main.dart';
import 'package:ebook/widgets/DogForm.dart';
import 'package:ebook/widgets/DogsAdoptionList.dart';
import 'package:ebook/widgets/MainPage.dart';
import 'package:ebook/widgets/big_text.dart';
import 'package:ebook/widgets/constants.dart';
import 'package:ebook/widgets/dimensions.dart';
import 'package:ebook/widgets/gridListMyDogs.dart';
import 'package:ebook/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ebook/utils/main.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:ebook/widgets/MainPage.dart';
import 'package:ebook/models/listas.dart';
import 'package:ebook/pages/home/main_settings.dart';
import 'package:location/location.dart' ;

class MainBookPage extends StatefulWidget {
  const MainBookPage({Key? key}) : super(key: key);
  @override
  _MainBookPageState createState() => _MainBookPageState();
}

class _MainBookPageState extends State<MainBookPage> {
  final _controller = PersistentTabController(initialIndex: 0);
    Location location = Location();
late bool _serviceEnabled;
late PermissionStatus _permissionGranted;
late LocationData _locationData;
var fieldLatitude;
var fieldLogitude;

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
    fetchData(AppConstants.APIBASE_URL);

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
        border: Border.all(color: Colors.blueGrey),
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
      screens:  [MainPage(), const DogsAdoptionList(), DogForm( lat: fieldLatitude, long: fieldLogitude,  )],
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.heart_circle_fill),
          title: ("Adopt"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.person_alt_circle_fill),
          title: ("MyDogs"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ],
    );
  }
}
