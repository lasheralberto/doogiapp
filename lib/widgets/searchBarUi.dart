import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class searchBarUI extends StatelessWidget {
  searchBarUI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final isPortrait = MediaQuery.of(context).orientation = Orientation.portrait;
    return FloatingSearchBar(
      hint: 'Search.....',
      openAxisAlignment: 0.0,
      width: 600,
      axisAlignment: 0.0,
      scrollPadding: EdgeInsets.only(top: 16, bottom: 20),
      elevation: 4.0,
      physics: BouncingScrollPhysics(),
      onQueryChanged: (query) {
        
        //Your methods will be here
      },
      automaticallyImplyDrawerHamburger: true,
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      transition: CircularFloatingSearchBarTransition(),
      debounceDelay: Duration(milliseconds: 500),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Icon(Icons.place),
            onPressed: () {
              print('Places Pressed');
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Material(
            color: Colors.white,
            child: Container(
              height: 200.0,
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    title: Text('Home'),
                    subtitle: Text('more info here........'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
