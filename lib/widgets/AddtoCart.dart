// ignore: file_names

// ignore_for_file: duplicate_import, file_names

import 'package:ebook/widgets/big_text.dart';
import 'package:ebook/widgets/dimensions.dart';
import 'package:flutter/material.dart';

class AppCart extends StatelessWidget{

  const AppCart(
      {Key? key,
      })
      : super(key: key);

@override
Widget build(BuildContext context) {
  return Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
            top: Dimensions.height20,
            bottom: Dimensions.height20,
            left: Dimensions.height10,
            right: Dimensions.height10),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimensions.radius20 * 2),
            topLeft: Radius.circular(Dimensions.radius20 * 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  right: Dimensions.height20,
                  left: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white),
              child: Row(
                children: [
                  const Icon(
                    Icons.remove,
                    color: Colors.black,
                  ),
                  SizedBox(width: Dimensions.width10),
                  BigText(text: '0'),
                  SizedBox(width: Dimensions.width10),
                  const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  right: Dimensions.height20,
                  left: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white),
              child: BigText(
                text: 'Add to cart',
              ),
            )
          ],
        ),
      );
}}
