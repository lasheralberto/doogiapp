import 'package:ebook/pages/books/popularbooksdetails.dart';
import 'package:flutter/material.dart';

class PopularBookDetailsSimplified extends StatelessWidget {
  final int index;
  final List<dynamic> doglist;
  
  const PopularBookDetailsSimplified(
      {Key? key, required this.index, required this.doglist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopularBookDetails(
      firstJsonParam: doglist[index].breed ?? '',
      secondJsonParam: doglist[index].origin ?? '',
      imgParam: doglist[index].urls2[0].urlBreed.isEmpty
          ? doglist[index].urls2[0].urlBreed[0]
          : doglist[index].urls2[0].urlBreed[2],
      //Random().nextInt(4)
      descriptionText: doglist[index].wikiDescr[0].contenido.toString(),
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
    );
  }
}
