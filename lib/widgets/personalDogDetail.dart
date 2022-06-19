import 'package:ebook/widgets/SlidingPanelDetails.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'dimensions.dart';

class personalDogDetail extends StatelessWidget {
  final String title;
  final String Age;
  var img;
  final String? description;
  var breed;
  var screen;

  personalDogDetail(

      {Key? key,

      required this.title,
      required this.Age,
      this.img,
      this.description,
      this.breed,
      required this.screen
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        Stack(children: [
 
          Align(
            alignment: Alignment.topCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                img,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ]),
        SlidingPanelDescription(
          screen: screen,
          panelstate: PanelState.OPEN,
          leftPosition: 0,
          rigthPosition: 0,
          bottomPosition: 80,
          topPosition: Dimensions.popularBookIMGSize,
          firstJsonParam: title,
          secondJsonParam: breed,
          descriptionText: description,
        )
      ]),
    );
  }
}
