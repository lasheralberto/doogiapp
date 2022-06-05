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
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PopularBookDetails extends StatelessWidget {
  final String firstJsonParam;
  final String secondJsonParam;
  final String? imgParam;
  final ParseFile? imgParamGrid;
  final String descriptionText;
  final int? param_good_children;
  final int? param_good_dogs;
  final int? good_with_strangers;
  final int? playfulness;
  final int? protectiveness;
  final int? trainability;
  final int? energy;
  final int? barking;
  final int? maxHeigthFemale;
  final int? maxHeigthMale;
  final int? maxLifeExp;
  final int? maxWeigthFemale;
  final int? maxWeigthMale;
  final int? minLifeExp;

  bool physicalCard = true;

  PopularBookDetails({
    Key? key,
    required this.firstJsonParam,
    required this.secondJsonParam,
     this.imgParam,
    required this.descriptionText,
    this.param_good_children,
    this.param_good_dogs,
    this.good_with_strangers,
    this.playfulness,
    this.protectiveness,
    this.trainability,
    this.energy,
    this.barking,
    this.maxHeigthFemale,
    this.maxHeigthMale,
    this.maxLifeExp,
    this.maxWeigthFemale,
    this.maxWeigthMale,
    this.minLifeExp, 
    this.imgParamGrid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(fit: StackFit.loose,
       children: [
        Positioned(
          child: SizedBox(
              width: double.maxFinite / 2,
              height: MediaQuery.of(context).size.height,
              child: DogCardDetails(
                imgparam: imgParam as String,
                barking: barking as int,
                energy: energy as int,
                good_with_strangers: good_with_strangers as int,
                param_good_children: param_good_children as int,
                param_good_dogs: param_good_dogs as int,
                playfulness: playfulness as int,
                protectiveness: protectiveness as int,
                trainability: trainability as int,
                maxHeigthFemale: maxHeigthFemale,
                maxHeigthMale: maxHeigthMale,
                maxLifeExp: maxLifeExp,
                maxWeigthFemale: maxWeigthFemale,
                maxWeigthMale: maxWeigthMale,
                minLifeExp: minLifeExp,
              )),
        ),
        
        SlidingPanelDescription(
          leftPosition: 0,
          rigthPosition: 0,
          bottomPosition: 0,
          topPosition: Dimensions.popularBookIMGSize,
          firstJsonParam: firstJsonParam,
          descriptionText: descriptionText,
          screen: 'dogcard_detail',
        )
      ]),
    );
  }
}
