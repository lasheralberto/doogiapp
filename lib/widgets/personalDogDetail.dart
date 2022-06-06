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

  personalDogDetail(
      {Key? key,
      required this.title,
      required this.Age,
      this.img,
      this.description,
      this.breed})
      : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        Stack(children: [
          //   Container(
          //   height: MediaQuery.of(context).size.height * 0.3,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: NetworkImage(img as String) ) ,
          //   ),
          // ),
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
          screen: 'personal_detail',
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
