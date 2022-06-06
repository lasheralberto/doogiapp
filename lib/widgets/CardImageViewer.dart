// import 'package:ebook/models/listas.dart';
// import 'package:ebook/widgets/big_text.dart';
// import 'package:ebook/widgets/dimensions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class CardViewer extends StatefulWidget{
//    CardViewer({Key ? key}) : super(key: key);
//   @override
//   _CardViewerState createState() =>  _CardViewerState();}

//   class _CardViewerState extends State<CardViewer>{


//       PageController pageController = PageController(viewportFraction: 0.70);
//       var _currPageValue = 0.1;
//       double scaleFactor = 0.8;
//       final double _height = Dimensions.pageViewContainer;
//       bool loading = true;

  


//   @override
//   // ignore: must_call_super
//   void dispose() {
//     pageController.dispose();
//   }
//       pageController.addListener((), {Key? key} {
//       //get current page value
//       setState(() {
//         _currPageValue = pageController.page!;
//       });
//     }) : super(key: key);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//             SizedBox(
//           height: Dimensions.pageView,
//           child: PageView.builder(
//               //depende de dos parámetros el builder. Position cogerá desde el index 0 al itemcount.
//               itemCount: items.length,
//               controller: pageController,
//               itemBuilder: (context, position) {
//                 return _buildPageItem(position);
//               }),
//         ),
//         DotsIndicator(
//           dotsCount: items.length,
//           position: _currPageValue,
//           decorator: DotsDecorator(
//             size: const Size.square(9.0),
//             activeSize: const Size(18.0, 9.0),
//             activeShape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(Dimensions.radius20)),
//           ),
//         ),;
//   }

// Widget _buildPageItem(int index, doglist ) {
//     //api from flutter. Rescale widget
//     Matrix4 matrix = Matrix4.identity();
//     if (index == _currPageValue.floor()) {
//       var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currPageValue.floor() + 1) {
//       var currScale =
//           scaleFactor + (_currPageValue - index + 1) * (1 - scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currPageValue.floor() - 1) {
//       var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else {
//       var currScale = 0.6;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, _height * (1 - scaleFactor), 0);
//     }

//     return Transform(
//       transform: matrix,
//       child: Stack(
//         children: [
//           Expanded(
//             child: InkWell(
//               onTap: () {
//                 // if (index == 0) {
//                 //   Navigator.push(
//                 //       context,
//                 //       MaterialPageRoute(
//                 //           builder: (context) => CostLivingTable(
//                 //                 index: index,
//                 //               )));
//                 // }
//               },
//               child: Container(
//                   height: Dimensions.pageViewContainer,
//                   margin: const EdgeInsets.only(left: 5, right: 5),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(Dimensions.radius30),
//                       color: index.isEven
//                           ? Colors.blueAccent
//                           : Colors.yellowAccent,
//                       image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: NetworkImage(
//                               'https://source.unsplash.com/random/?${itemsComplement[index]}')))),
//             ),
//           ),

//           //container pequeño con texto
//           Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 height: Dimensions.pageViewTextContainer,
//                 width: 230,
//                 margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(Dimensions.radius20),
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Colors.blueAccent,
//                             spreadRadius: 0.5,
//                             blurRadius: 0,
//                             offset: Offset(0, 3))
//                       ]),
//                   padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
//                   child: Center(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         BigText(text: doglist[index]),
//                         // ignore: prefer_const_constructors
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Icon(iconos[index]),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               height: Dimensions.height10,
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: Dimensions.height10,
//                         ),
//                         const SizedBox(width: 10),
//                       ],
//                     ),
//                   ),
//                 ),
//               ))
//         ],
//       ),
//     );
  
//   }

  