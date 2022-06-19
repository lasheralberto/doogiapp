// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

class BehaviorCard extends StatelessWidget {
  //final String imgparam;
  final int param_good_children;
  final int param_good_dogs;
  final int good_with_strangers;
  final int playfulness;
  final int protectiveness;
  final int trainability;
  final int energy;
  final int barking;


  const BehaviorCard(
      // ignore: non_constant_identifier_names
      {
    Key? key,
    //required this.imgparam,
    required this.param_good_children,
    required this.param_good_dogs,
    required this.good_with_strangers,
    required this.playfulness,
    required this.protectiveness,
    required this.trainability,
    required this.energy,
    required this.barking, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, top: 8),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text(
                      'Good with children:     ',
                    ),
                    Flexible(
                      child: GFProgressBar(
                        lineHeight: 10,
                        width: MediaQuery.of(context).size.width / 4,
                        percentage: (param_good_children / 10) * 2,
                        backgroundColor: Colors.pink,
                        progressBarColor: Colors.blue,
                        animation: true,
                      ),
                    ),
                    Text((param_good_children * 2).toString())
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Good with other dogs:',
                    ),
                    Flexible(
                      child: GFProgressBar(
                        lineHeight: 10,
                        width: MediaQuery.of(context).size.width / 4,
                        percentage: (param_good_dogs / 10) * 2,
                        backgroundColor: Colors.pink,
                        progressBarColor: Colors.blue,
                        animation: true,
                      ),
                    ),
                    Text((param_good_dogs * 2).toString())
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Good with strangers:  ',
                    ),
                    Flexible(
                      child: GFProgressBar(
                        lineHeight: 10,
                        width: MediaQuery.of(context).size.width / 4,
                        percentage: (good_with_strangers / 10) * 2,
                        backgroundColor: Colors.pink,
                        progressBarColor: Colors.blue,
                        animation: true,
                      ),
                    ),
                    Text((good_with_strangers * 2).toString())
                  ],
                ),
                Divider(
                  thickness: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Playful:                          ',
                    ),
                    Flexible(
                      child: GFProgressBar(
                        lineHeight: 10,
                        width: MediaQuery.of(context).size.width / 4,
                        percentage: (playfulness / 10) * 2,
                        backgroundColor: Colors.pink,
                        progressBarColor: Colors.blue,
                        animation: true,
                      ),
                    ),
                    Text((playfulness * 2).toString())
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Protectiviness:             ',
                    ),
                    Flexible(
                      child: GFProgressBar(
                        lineHeight: 10,
                        width: MediaQuery.of(context).size.width / 4,
                        percentage: (protectiveness / 10) * 2,
                        backgroundColor: Colors.pink,
                        progressBarColor: Colors.blue,
                        animation: true,
                      ),
                    ),
                    Text((protectiveness * 2).toString())
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Trainability:                   ',
                    ),
                    Flexible(
                      child: GFProgressBar(
                        lineHeight: 10,
                        width: MediaQuery.of(context).size.width / 4,
                        percentage: (trainability / 10) * 2,
                        backgroundColor: Colors.pink,
                        progressBarColor: Colors.blue,
                        animation: true,
                      ),
                    ),
                    Text((trainability * 2).toString())
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Energy:                           ',
                    ),
                    Flexible(
                      child: GFProgressBar(
                        lineHeight: 10,
                        width: MediaQuery.of(context).size.width / 4,
                        percentage: (energy / 10) * 2,
                        backgroundColor: Colors.pink,
                        progressBarColor: Colors.blue,
                        animation: true,
                      ),
                    ),
                    Text((energy * 2).toString())
                  ],
                ),
                const Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Barking:                          ',
                    ),
                    Flexible(
                      child: GFProgressBar(
                        lineHeight: 10,
                        width: MediaQuery.of(context).size.width / 4,
                        percentage: (barking / 10) * 2,
                        backgroundColor: Colors.pink,
                        progressBarColor: Colors.blue,
                        animation: true,
                      ),
                    ),
                    Text((barking * 2).toString())
                  ],
                ),
                Divider(
                  color: Colors.pink,
                  thickness: 2.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
