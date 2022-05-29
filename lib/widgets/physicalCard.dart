// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

class PhysicalCardInfoDog extends StatelessWidget {
  final dynamic minLifeExp;
  final dynamic maxLifeExp;
  final dynamic maxHeigthMale;
  final dynamic maxHeigthFemale;
  final dynamic maxWeigthMale;
  final dynamic maxWeigthFemale;

  const PhysicalCardInfoDog(
      {Key? key,
      required this.minLifeExp,
      required this.maxLifeExp,
      required this.maxHeigthMale,
      required this.maxHeigthFemale,
      required this.maxWeigthMale,
      required this.maxWeigthFemale})
      : super(key: key);

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
                          'Min life expectancy:      ',
                        ),
                        Flexible(
                          child: GFProgressBar(
                            lineHeight: 10,
                            width: MediaQuery.of(context).size.width / 4,
                            percentage: (minLifeExp / 100) * 2,
                            backgroundColor: Colors.pink,
                            progressBarColor: Colors.blue,
                            animation: true,
                          ),
                        ),
                        Text((minLifeExp * 2).toString())
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Max life expectancy:     ',
                        ),
                        Flexible(
                          child: GFProgressBar(
                            lineHeight: 10,
                            width: MediaQuery.of(context).size.width / 4,
                            percentage: (maxLifeExp / 100) * 2,
                            backgroundColor: Colors.pink,
                            progressBarColor: Colors.blue,
                            animation: true,
                          ),
                        ),
                        Text((maxLifeExp * 2).toString())
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Male max heigth:           ',
                        ),
                        Flexible(
                          child: GFProgressBar(
                            lineHeight: 10,
                            width: MediaQuery.of(context).size.width / 4,
                            percentage: (maxHeigthMale / 100) * 2,
                            backgroundColor: Colors.pink,
                            progressBarColor: Colors.blue,
                            animation: true,
                          ),
                        ),
                        Text((maxHeigthMale * 2).toString())
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Female max heigth:       ',
                        ),
                        Flexible(
                          child: GFProgressBar(
                            lineHeight: 10,
                            width: MediaQuery.of(context).size.width / 4,
                            percentage: (maxHeigthFemale / 100) * 2,
                            backgroundColor: Colors.pink,
                            progressBarColor: Colors.blue,
                            animation: true,
                          ),
                        ),
                        Text((maxHeigthFemale * 2).toString())
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Male max weigth:          ',
                        ),
                        Flexible(
                          child: GFProgressBar(
                            lineHeight: 10,
                            width: MediaQuery.of(context).size.width / 4,
                            percentage: (maxWeigthMale / 100),
                            backgroundColor: Colors.pink,
                            progressBarColor: Colors.blue,
                            animation: true,
                          ),
                        ),
                        Text((maxWeigthMale).toString())
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Female max weigth:     ',
                        ),
                        Flexible(
                          child: GFProgressBar(
                            lineHeight: 10,
                            width: MediaQuery.of(context).size.width / 4,
                            percentage: (maxWeigthFemale / 100),
                            backgroundColor: Colors.pink,
                            progressBarColor: Colors.blue,
                            animation: true,
                          ),
                        ),
                        Text((maxWeigthFemale).toString())
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                  ]),
            ),
          ),
        ));
  }
}
