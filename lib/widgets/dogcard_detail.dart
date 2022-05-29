//import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:ebook/widgets/BehaviorCard.dart';
import 'package:flutter/material.dart';
import 'physicalCard.dart';

class DogCardDetails extends StatefulWidget {
  final String imgparam;
  final int param_good_children;
  final int param_good_dogs;
  final int good_with_strangers;
  final int playfulness;
  final int protectiveness;
  final int trainability;
  final int energy;
  final int barking;
  final dynamic minLifeExp;
  final dynamic maxLifeExp;
  final dynamic maxHeigthMale;
  final dynamic maxHeigthFemale;
  final dynamic maxWeigthMale;
  final dynamic maxWeigthFemale;

  const DogCardDetails({
    Key? key,
    required this.imgparam,
    required this.param_good_children,
    required this.param_good_dogs,
    required this.good_with_strangers,
    required this.playfulness,
    required this.protectiveness,
    required this.trainability,
    required this.energy,
    required this.barking,
    required this.minLifeExp,
    required this.maxLifeExp,
    required this.maxHeigthMale,
    required this.maxHeigthFemale,
    required this.maxWeigthMale,
    required this.maxWeigthFemale,
  }) : super(key: key);

  @override
  State<DogCardDetails> createState() => _DogCardDetailsState();
}

class _DogCardDetailsState extends State<DogCardDetails> {
  final bool _visibleBehavior = false;

  bool _visiblePhysical = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.imgparam,
                width: 350,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(
                right: 20,
                left: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _visiblePhysical = false;
                        });
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(160.0),
                                      side: BorderSide(color: Colors.white)))),
                      child: Text('Behavior info')),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _visiblePhysical = true;
                        });
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(160.0),
                                      side: BorderSide(color: Colors.white)))),
                      child: Text('Physical info')),
                ],
              ),
            ),
            _visiblePhysical == true
                ? PhysicalCardInfoDog(
                    minLifeExp: widget.minLifeExp,
                    maxLifeExp: widget.maxLifeExp,
                    maxHeigthMale: widget.maxHeigthMale,
                    maxHeigthFemale: widget.maxHeigthFemale,
                    maxWeigthMale: widget.maxWeigthMale,
                    maxWeigthFemale: widget.maxWeigthFemale)
                : BehaviorCard(
                    imgparam: widget.imgparam,
                    param_good_children: widget.param_good_children,
                    param_good_dogs: widget.param_good_dogs,
                    good_with_strangers: widget.good_with_strangers,
                    playfulness: widget.playfulness,
                    protectiveness: widget.protectiveness,
                    trainability: widget.trainability,
                    energy: widget.energy,
                    barking: widget.barking)
          ],
        ),
      ),
    );
  }
}
