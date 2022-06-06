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
  const BookPageBody({Key? key}) : super(key: key);

  @override
  _BookPageBodyState createState() => _BookPageBodyState();
}

class _BookPageBodyState extends State<BookPageBody> {
  //pagecontroller hace que sea visible el anterior y el posterior slide en la pantalla

  late List<Item> itemsLoad;
  bool? _loadingMore;
  late bool _hasMoreItems;
  late final int _maxItems = BreedList.length;
  final int _numItemsPage = 5;
  Future? _initialLoad;

  Future _loadMoreItems() async {
    //cuando se llame iterará hasta la pos 10, returning False hasta que no llegue
    final totalItems = itemsLoad.length;
    await Future.delayed(const Duration(seconds: 1), () {
      for (var i = 0; i < _numItemsPage; i++) {
        itemsLoad.add(Item(totalItems + i + 1));
      }
    });
    _hasMoreItems = itemsLoad.length < _maxItems;
  }

  @override
  void initState() {
    super.initState();
    fetchData(AppConstants.APIBASE_URL);

    _initialLoad = Future.delayed(const Duration(seconds: 3), () {
      // List items = [];
      itemsLoad = <Item>[];
      for (var i = 1; i < _numItemsPage; i++) {
        itemsLoad.add(Item(i + 1));
      }
      _hasMoreItems = true;
    });
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
                  BigText(text: 'Breed List'),
                ])),
        FutureBuilder(
            future: _initialLoad,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());

                case ConnectionState.done:
                  return IncrementallyLoadingListView(
                      hasMore: () => _hasMoreItems,
                      loadMore: () async {
                        await _loadMoreItems();
                      },
                      onLoadMore: () {
                        setState(() {
                          _loadingMore = true;
                        });
                      },
                      onLoadMoreFinished: () {
                        setState(() {
                          _loadingMore = false;
                        });
                      },
                      loadMoreOffsetFromBottom: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: () => itemsLoad.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        //final itemtoLoad = itemsLoad[index];
                        if (_loadingMore ?? false)
                        // && index == itemsLoad.length )
                        {
                          ///-1
                          return ListCard(
                            index: index,
                            doglist: BreedList,
                          );
                        } else {
                          return ListCard(
                            index: index,
                            doglist: BreedList,
                          );
                        }
                      });
                case ConnectionState.none:
                  return const Text('None');
                case ConnectionState.active:
                  return const Text('Active');
              }
            })
      ]),
    );
  }
}
