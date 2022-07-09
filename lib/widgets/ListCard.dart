// ignore_for_file: file_names, prefer_const_constructors

import 'package:ebook/widgets/PopularDetailsBreedSimplified.dart';
import 'package:ebook/widgets/app_column.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dimensions.dart';
import 'dart:math';

class ListCard extends StatelessWidget {
  final int index;
  final List<dynamic> doglist;
  final String? screen;

  Random random = Random();

  ListCard({Key? key, required this.index, required this.doglist, this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //int randomNumber =  Random().nextInt(10);
    return Material(
      child: Container(
        margin: EdgeInsets.only(
            top: screen == 'ML' ? 0.0 : Dimensions.height10,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: screen == 'ML' ? 50.0 : Dimensions.height10),
        child: Row(
          children: [
            //container correspondiente a la imagen
            Container(
              margin: EdgeInsets.all(5),
              width: Dimensions.listViewImgSize,
              height: Dimensions.listViewImgSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white38,
              ),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipOval(
                    child: FadeInImage.memoryNetwork(
                      image: doglist[index].urls2[0].urlBreed[1] ??
                          doglist[index].urls2[0].urlBreed[0],
                      placeholder: kTransparentImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PopularBookDetailsSimplified(
                              index: index, doglist: doglist)));
                },
                child: Container(
                  height: Dimensions.pageViewTextContainer,
                  width: Dimensions.listViewTextContSize,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.blueGrey,
                            blurRadius: 1,
                            offset: Offset(0, 3))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.blueAccent),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.height10),
                        AppColumn(
                          headertext: doglist[index].breed ?? '',
                          subHeaderText: doglist[index].origin ?? '',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
