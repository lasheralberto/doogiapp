import 'package:ebook/widgets/SlidingPanelDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'dimensions.dart';

class personalDogDetail extends StatelessWidget {
  final String title;
  final String Age;
  var img;
  final String? description;
  var breed;

  personalDogDetail({
    Key? key, required this.title, required this.Age, this.img, this.description, this.breed
  }) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
        Positioned(
          child: SizedBox(
            width: double.maxFinite,
              height: MediaQuery.of(context).size.height,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(img as String) ) ,
              ),
            ),
          ),
        ),
        Container(),
         
        SlidingPanelDescription(
          screen: 'personal_detail',
          panelstate: PanelState.CLOSED,
          leftPosition: 0,
          rigthPosition: 0,
          bottomPosition: 80,
          topPosition: Dimensions.popularBookIMGSize,
          firstJsonParam: title,
          secondJsonParam: breed ,
          descriptionText: description,
          
        )
      ]),
    );
  }
}
