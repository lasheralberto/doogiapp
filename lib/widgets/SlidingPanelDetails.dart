// ignore_for_file: file_names, prefer_const_constructors

import 'package:ebook/widgets/TomTomMap.dart';
import 'package:ebook/widgets/big_text.dart';
import 'package:ebook/widgets/dimensions.dart';
import 'package:ebook/widgets/exp_text_widget.dart';
import 'package:ebook/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingPanelDescription extends StatefulWidget {
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
  var lat;
  var long;

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
      this.screen,
      this.lat,
      this.long})
      : super(key: key);

  @override
  State<SlidingPanelDescription> createState() =>
      _SlidingPanelDescriptionState();
}

class _SlidingPanelDescriptionState extends State<SlidingPanelDescription> {
  final PanelController _pc1 = PanelController();
  late TextEditingController pc_edit_descr;
  String editedText = '';

  bool editable = false;
  bool saveDescrButton = false;
  bool _visible = true;
  bool textEdited = false;

  final bool _physicalCard = true;

  void saveModifiedDescr(String descr) async {
    await updateTodo(descr, widget.firstJsonParam);
  }

  @override
  void initState() {
    // Initialize TextEditingController object with default text.
    textEdited == false
        ? pc_edit_descr = TextEditingController(text: widget.descriptionText)
        : pc_edit_descr = TextEditingController(text: editedText);

    //saveModifiedDescr(editedText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainState: true,
      maintainAnimation: true,
      visible: _visible,
      child: SlidingUpPanel(
          controller: _pc1,
          snapPoint: 0.9,
          defaultPanelState: widget.panelstate as PanelState,
          backdropTapClosesPanel: true,
          borderRadius: BorderRadius.circular(100),
          maxHeight: MediaQuery.of(context).size.height * 60 / 100,
          minHeight: MediaQuery.of(context).size.height * 13 / 100,
          panel: Positioned(
            left: widget.leftPosition,
            right: widget.rigthPosition,
            bottom: widget.bottomPosition,
            top: widget.topPosition,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: BigText(text: widget.firstJsonParam)),
                      FloatingActionButton(
                          child: Icon(Icons.map_rounded),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TomTomMap(
                                        screen: widget.screen,
                                        lat: widget.lat,
                                        long: widget.long)));
                          })
                    ],
                  ),
                  SmallText(
                      text: widget.screen == 'personal_detailForm'
                          ? widget.secondJsonParam as String
                          : ''),
                  widget.screen == 'personal_detailForm'
                      ? IconButton(
                          color: Colors.black,
                          onPressed: () {
                            if (editable == false) {
                              setState(() {
                                editable = true;
                              });
                            } else if (editable == true) {
                              setState(() {
                                editable = false;
                              });
                            }
                          },
                          icon: Icon(Icons.edit,
                              color:
                                  editable == true ? Colors.red : Colors.black))
                      : SizedBox(
                          height: 10,
                        ),
                  ButtonBar(
                    mainAxisSize: MainAxisSize
                        .min, // this will take space as minimum as posible(to center)
                    children: <Widget>[
                      widget.screen == 'dogcard_detail'
                          ? ElevatedButton(
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
                            )
                          : SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height20 - 10,
                  ),
                  Expanded(
                      //to make it  scrollable
                      child: editable == true &&
                              widget.screen == 'personal_detailForm'
                          ? Column(
                              children: [
                                TextField(
                                  minLines: 1,
                                  maxLines: 7,
                                  keyboardType: TextInputType.multiline,
                                  controller: pc_edit_descr,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FloatingActionButton(
                                    tooltip: 'Save changes',
                                    child: Icon(Icons.thumb_up_alt),
                                    onPressed: () {
                                      setState(() {
                                        editable = false;
                                        textEdited = true;
                                        editedText = pc_edit_descr.text;

                                        saveModifiedDescr(editedText);
                                      });
                                    })
                              ],
                            )
                          : SingleChildScrollView(
                              child: ExpandableText(
                                  text: textEdited == false
                                      ? widget.descriptionText as String
                                      : editedText)
                              //'From Romeo and Juliet to King Lear to Macbeth to all of his stunning sonnets and other works, William Shakespeare’s top spot in the literary world has been solidified for centuries. Although his work is well-covered in many schools, famous Shakespeare quotes do not only belong in English courses for study. We can all appreciate his tongue-in-cheek observations about society and individuals’ behavior, as well as gain inspiration and wisdom from his quick-witted quips and smart sense of humor. Not only that, he can help us find beauty through language—including an appreciation for vulnerable declarations of love.'),
                              ))
                ])),
          )),
    );
  }
}

Future<void> updateTodo(String description, String dogName) async {
  ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;

  var concatid = currentUser!.objectId! + dogName;

  // QueryBuilder<ParseObject> queryTodo =
  //     QueryBuilder<ParseObject>(ParseObject('Todo'));
  // queryTodo.whereEqualTo('concatId', concatid.toString());
  // final ParseResponse apiResponse = await queryTodo.query();

  //queryTodo.find();
  await Future.delayed(Duration(seconds: 1), () {});
  final todo = ParseObject('Todo')
    ..objectId = currentUser.objectId
    ..set('concatId', concatid)
    ..set('DogDescription', description);

  await todo.save();
}
