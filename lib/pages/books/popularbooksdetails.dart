// ignore_for_file: unused_import, unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/widgets/AddtoCart.dart';
import 'package:ebook/widgets/SlidingPanelDetails.dart';
import 'package:ebook/widgets/app_column.dart';
import 'package:ebook/widgets/app_icon.dart';
import 'package:ebook/widgets/big_text.dart';
import 'package:ebook/widgets/dimensions.dart';
import 'package:ebook/widgets/dogcard_detail.dart';
import 'package:ebook/widgets/exp_text_widget.dart';
import 'package:ebook/widgets/icon_and_text_widget.dart';
import 'package:ebook/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PopularBookDetails extends StatelessWidget {
  final String firstJsonParam;
  final String secondJsonParam;
  final String imgParam;
  final String descriptionText;
  final int param_good_children;
  final int param_good_dogs;
  final int good_with_strangers;
  final int playfulness;
  final int protectiveness;
  final int trainability;
  final int energy;
  final int barking;
  final int maxHeigthFemale;
  final int maxHeigthMale;
  final int maxLifeExp;
  final int maxWeigthFemale;
  final int maxWeigthMale;
  final int minLifeExp;

  bool physicalCard = true;

  PopularBookDetails({
    Key? key,
    required this.firstJsonParam,
    required this.secondJsonParam,
    required this.imgParam,
    required this.descriptionText,
    required this.param_good_children,
    required this.param_good_dogs,
    required this.good_with_strangers,
    required this.playfulness,
    required this.protectiveness,
    required this.trainability,
    required this.energy,
    required this.barking,
    required this.maxHeigthFemale,
    required this.maxHeigthMale,
    required this.maxLifeExp,
    required this.maxWeigthFemale,
    required this.maxWeigthMale,
    required this.minLifeExp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(fit: StackFit.loose, children: [
        Positioned(
          child: SizedBox(
              width: double.maxFinite / 2,
              height: MediaQuery.of(context).size.height,
              
              child: DogCardDetails(
                imgparam: imgParam,
                barking: barking,
                energy: energy,
                good_with_strangers: good_with_strangers,
                param_good_children: param_good_children,
                param_good_dogs: param_good_dogs,
                playfulness: playfulness,
                protectiveness: protectiveness,
                trainability: trainability,
                maxHeigthFemale: maxHeigthFemale,
                maxHeigthMale: maxHeigthMale,
                maxLifeExp: maxLifeExp,
                maxWeigthFemale: maxWeigthFemale,
                maxWeigthMale: maxWeigthMale,
                minLifeExp: minLifeExp,
              )),
        ),
        Positioned(
          top: Dimensions.height20,
          left: Dimensions.width20,
          right: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              InkWell(
                child: const AppIcon(icon: Icons.arrow_back_ios_new),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const AppIcon(icon: Icons.shopping_bag_rounded),
            ],
          ),
        ),
        SlidingPanelDescription(
          leftPosition: 0,
          rigthPosition: 0,
          bottomPosition: 0,
          topPosition: Dimensions.popularBookIMGSize,
          firstJsonParam: firstJsonParam,
          descriptionText: descriptionText,
        )
      ]),
    );
  }
}
