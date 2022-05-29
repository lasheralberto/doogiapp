// ignore_for_file: file_names, prefer_const_constructors

import 'package:ebook/pages/books/popularbooksdetails.dart';
import 'package:ebook/widgets/app_column.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dimensions.dart';
import 'dart:math';

class ListCard extends StatelessWidget {
  final int index;
  final List<dynamic> doglist;

  Random random = Random();

  ListCard({Key? key, required this.index, required this.doglist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //int randomNumber =  Random().nextInt(10);
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.height10,
          left: Dimensions.width20,
          right: Dimensions.width20,
          bottom: Dimensions.height10),
      child: Row(
        children: [
          //container correspondiente a la imagen
          Container(
            margin: EdgeInsets.all(5),
            width: Dimensions.listViewImgSize,
            height: Dimensions.listViewImgSize,
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipOval(
                  child: FadeInImage.memoryNetwork(
               
                    image: doglist[index].urls2[0].urlBreed[1] ?? doglist[index].urls2[0].urlBreed[0],
                    placeholder: kTransparentImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white38,
            ),
          ),

          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PopularBookDetails(
                        firstJsonParam: doglist[index].breed ?? '',
                        secondJsonParam: doglist[index].origin ?? '',
                        imgParam: doglist[index].urls2[0].urlBreed.isEmpty
                            ? doglist[index].urls2[0].urlBreed[0]
                            : doglist[index].urls2[0].urlBreed[2],
                        //Random().nextInt(4)
                        descriptionText:
                            doglist[index].wikiDescr[0].contenido.toString(),
                        barking: doglist[index].barking,
                        energy: doglist[index].energy,
                        good_with_strangers: doglist[index].goodWithStrangers,
                        param_good_children: doglist[index].goodWithChildren,
                        param_good_dogs: doglist[index].goodWithOtherDogs,
                        playfulness: doglist[index].playfulness,
                        protectiveness: doglist[index].protectiveness,
                        trainability: doglist[index].trainability,
                        maxHeigthFemale: doglist[index].maxHeightFemale,
                        maxHeigthMale: doglist[index].maxHeightMale,
                        maxLifeExp: doglist[index].maxLifeExpectancy,
                        maxWeigthFemale: doglist[index].maxWeightFemale,
                        maxWeigthMale: doglist[index].maxWeightMale,
                        minLifeExp: doglist[index].minLifeExpectancy,
                      ),
                    ));
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
    );
  }
}
