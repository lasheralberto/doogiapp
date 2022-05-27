import 'package:ebook/widgets/dimensions.dart';
import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  //we pass the color var
  final Color? color;
  final String text;
  final String? fontFamily;
  final FontWeight? fontStrength;
  double size;
  TextOverflow overFlow;

  BigText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.fontFamily,
      this.fontStrength,
      this.size = 18,
      this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: overFlow,
        style: TextStyle(
          fontSize: size == 0 ? Dimensions.font20 : size,
          fontFamily: fontFamily ?? 'Fredoka-Bold',
          color: color,
          fontWeight: fontStrength ?? FontWeight.w500,
        ));
  }
}
