import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  //we pass the color var
  final Color? color;
  final String text;
  double size;
  double height;

  SmallText({
    Key? key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 14,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: size,
            fontFamily: 'Fredoka-Regular',
            color: color,
            fontWeight: FontWeight.w400,
            height: height));
  }
}
