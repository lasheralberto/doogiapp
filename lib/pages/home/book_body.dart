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
  PageController pageController = PageController(viewportFraction: 0.70);
  var _currPageValue = 0.1;
  double scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;
  bool loading = true;

  late List<Item> itemsLoad;
  bool? _loadingMore;
  late bool _hasMoreItems;
  late final int _maxItems = BreedList.length;
  final int _numItemsPage = 3;
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
    //fetchData(AppConstants.APIBASE_URL);

    _initialLoad = Future.delayed(const Duration(seconds: 3), () {
      // List items = [];
      itemsLoad = <Item>[];
      for (var i = 1; i < _numItemsPage; i++) {
        itemsLoad.add(Item(i + 1));
      }
      _hasMoreItems = true;
    });

    

    pageController.addListener(() {
      //get current page value
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  // ignore: must_call_super
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Column(
        children: [
        //********************PARTE DE ARRIBA SCROLLABLE CARDS****************************************** */
        SizedBox(
          height: Dimensions.pageView,
          child: PageView.builder(
              //depende de dos parámetros el builder. Position cogerá desde el index 0 al itemcount.
              itemCount: items.length,
              controller: pageController,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        DotsIndicator(
          dotsCount: items.length,
          position: _currPageValue,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius20)),
          ),
        ),
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
            future: fetchData(AppConstants.APIBASE_URL),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                
                case ConnectionState.waiting:
                  return const Center(child: 
                  CircularProgressIndicator());

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
                            { ///-1
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

  Widget _buildPageItem(int index) {
    //api from flutter. Rescale widget
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (_currPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.6;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - scaleFactor), 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                // if (index == 0) {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => CostLivingTable(
                //                 index: index,
                //               )));
                // }
              },
              child: Container(
                  height: Dimensions.pageViewContainer,
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: index.isEven
                          ? Colors.blueAccent
                          : Colors.yellowAccent,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://source.unsplash.com/random/?${itemsComplement[index]}')))),
            ),
          ),

          //container pequeño con texto
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer,
                width: 230,
                margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.blueAccent,
                            spreadRadius: 0.5,
                            blurRadius: 0,
                            offset: Offset(0, 3))
                      ]),
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BigText(text: items[index]),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 5,
                        ),
                        Icon(iconos[index]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

