// ignore_for_file: file_names, prefer_const_constructors

import 'package:ebook/widgets/big_text.dart';
import 'package:ebook/widgets/dimensions.dart';
import 'package:ebook/widgets/exp_text_widget.dart';
import 'package:ebook/widgets/small_text.dart';
import 'package:flutter/material.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingPanelDescription extends StatelessWidget {
  final String firstJsonParam;
  final String? secondJsonParam;
  final String? imgParam;
  final String? descriptionText;
  final double? leftPosition;
  final double? rigthPosition;
  final double? bottomPosition;
  final double? topPosition;
  final PanelState? panelstate;
  final String? screen;

  final PanelController _pc1 = PanelController();

  bool _visible = true;
  final bool _physicalCard = true;

  SlidingPanelDescription(
      {Key? key,
      required this.firstJsonParam,
      this.secondJsonParam,
      this.imgParam,
      this.descriptionText,
      this.leftPosition,
      this.rigthPosition,
      this.bottomPosition,
      this.topPosition,
      this.panelstate,
      this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainState: true,
      maintainAnimation: true,
      visible: _visible,
      child: SlidingUpPanel(
          controller: _pc1,
          snapPoint: 0.9,
          defaultPanelState: panelstate as PanelState,
          backdropTapClosesPanel: true,
          borderRadius: BorderRadius.circular(100),
          maxHeight: MediaQuery.of(context).size.height * 60 / 100,
          minHeight: MediaQuery.of(context).size.height * 13 / 100,
          panel: Positioned(
            left: leftPosition,
            right: rigthPosition,
            bottom: bottomPosition,
            top: topPosition,
            child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20)),
                    color: Colors.white),
                child: Column(children: [
                  SizedBox(height: Dimensions.height10),
                  BigText(text: firstJsonParam),
                  SmallText(text: screen == 'personal_detail' ? secondJsonParam as String : ''),
                  BigText(
                    text: '',
                    size: Dimensions.font26,
                    fontFamily: 'Fredoka-Medium',
                    fontStrength: FontWeight.w400,
                  ),
                  ButtonBar(
                    mainAxisSize: MainAxisSize
                        .min, // this will take space as minimum as posible(to center)
                    children: <Widget>[
                      screen == 'dogcard_detail' ?
                      ElevatedButton(
                        child: Text('More info'),
                        onPressed: () {
                          if (_visible == true) {
                            _pc1.close();
                            _visible = false;
                          } else {
                            _pc1.open();
                            _visible = true;
                          }
                        },
                      ) : SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height20 - 10,
                  ),
                  Expanded(
                      //to make it  scrollable
                      child: SingleChildScrollView(
                          child: ExpandableText(text: descriptionText as String)
                          //'From Romeo and Juliet to King Lear to Macbeth to all of his stunning sonnets and other works, William Shakespeare’s top spot in the literary world has been solidified for centuries. Although his work is well-covered in many schools, famous Shakespeare quotes do not only belong in English courses for study. We can all appreciate his tongue-in-cheek observations about society and individuals’ behavior, as well as gain inspiration and wisdom from his quick-witted quips and smart sense of humor. Not only that, he can help us find beauty through language—including an appreciation for vulnerable declarations of love.'),
                          ))
                ])),
          )),
    );
  }
}
