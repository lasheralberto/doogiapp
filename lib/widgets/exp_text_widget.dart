import 'package:ebook/widgets/dimensions.dart';
import 'package:ebook/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHald;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 2;

 

  @override
  //create method
  void initState() {
    super.initState();
    //check length of text
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHald =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);

    } else {
      firstHalf = widget.text;
      secondHald = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
        child: secondHald.isEmpty
            ? SmallText(size: Dimensions.font16, height: 1.8, text: firstHalf)
            : Column(
                children: [
                  SmallText(
                      height: 1.8,
                      size: Dimensions.font16,
                      text: hiddenText
                          ? ('$firstHalf...')
                          : (firstHalf + secondHald)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        //nos setea enfalse q es donde entramos en la condición de arriba
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(
                      children: [
                        SmallText(text: 'Show more', color: Colors.black),
                        Icon(
                          hiddenText
                              ? Icons.arrow_drop_down_circle_outlined
                              : Icons.arrow_drop_up_rounded,
                          color: Colors.redAccent,
                        )
                      ],
                    ),
                  )
                ],
              ));
  }
}
