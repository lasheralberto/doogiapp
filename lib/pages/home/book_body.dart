import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/models/listas.dart';
import 'package:ebook/widgets/ListCard.dart';
import 'package:ebook/widgets/big_text.dart';
import 'package:ebook/widgets/constants.dart';
import 'package:ebook/widgets/dimensions.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ebook/models/ItemsToLoad.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';

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
        //********************PARTE DE ARRIBA SCROLLABLE CARDS****************************************** */
        // SizedBox(
        //   height: Dimensions.pageView,
        //   child: PageView.builder(
        //       //depende de dos parámetros el builder. Position cogerá desde el index 0 al itemcount.
        //       itemCount: items.length,
        //       controller: pageController,
        //       itemBuilder: (context, position) {
        //         return _buildPageItem(position);
        //       }),
        // ),
        // DotsIndicator(
        //   dotsCount: items.length,
        //   position: _currPageValue,
        //   decorator: DotsDecorator(
        //     size: const Size.square(9.0),
        //     activeSize: const Size(18.0, 9.0),
        //     activeShape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(Dimensions.radius20)),
        //   ),
        // ),
        //************************************************************** */
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
