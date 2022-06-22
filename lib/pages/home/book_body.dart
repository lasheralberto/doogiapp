import 'package:ebook/widgets/ListCard.dart';
import 'package:ebook/widgets/big_text.dart';
import 'package:ebook/widgets/dimensions.dart';
import 'package:flutter/material.dart';

// create client instance
class BookPageBody extends StatefulWidget {
  List<dynamic> breedlist;
  var index;
  BookPageBody({Key? key, required this.breedlist, required this.index})
      : super(key: key);

  @override
  _BookPageBodyState createState() => _BookPageBodyState();
}

class _BookPageBodyState extends State<BookPageBody> {
  Future<List<dynamic>>? futureData;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [

        SizedBox(height: Dimensions.height20),
        Container(
            margin: EdgeInsets.only(left: Dimensions.width20),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BigText(text: ''),
                ])),
        ListCard(index: widget.index, doglist: widget.breedlist)
      ]),
    );
  }
}
