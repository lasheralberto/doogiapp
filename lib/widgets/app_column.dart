import 'package:ebook/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'big_text.dart';
import 'dimensions.dart';

class AppColumn extends StatelessWidget {
  final bool? sizedBoxHeaderText;
  final String headertext;
  final String subHeaderText;
  final String? textLeft;
  final String? textRight;
  final String? difficultyText;
  final Dimensions? dimSizedBox;

  const AppColumn(
      {Key? key,
      this.sizedBoxHeaderText = false,
      required this.headertext,
      required this.subHeaderText,
      this.textLeft,
      this.textRight,
      this.difficultyText,
      this.dimSizedBox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BigText(
          text: headertext,
          size: 15,
        ),
        SmallText(text: subHeaderText),
      ],
    );
  }
}
