// ignore_for_file: file_names, camel_case_types

import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/widgets/ListCard.dart';
import 'package:ebook/widgets/big_text.dart';
import 'package:ebook/widgets/constants.dart';
import 'package:ebook/widgets/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class foundDog extends StatelessWidget {
  List<dynamic> glossarlist;
  List<dynamic> filterlist;
  String query;

  foundDog(
      {Key? key,
      required this.filterlist,
      required this.glossarlist,
      required this.query})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
            for (int i = 0; i < BreedList.length; i++) {
              var item = BreedList[i].breed;
              //here I add to _filterList all the results that contains
              //that letter
              if ((item.toString().toLowerCase())
                  .contains(query.toLowerCase())) {
                filterlist.add(item.toString());
                filterlist.toSet().toList();
                glossarlist = filterlist;
              }
            }
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const CircularProgressIndicator();
            // } else {
            return ListView.builder(
                itemCount: filterlist.length,
                itemBuilder: (BuildContext context, int index) {
                  // for (int i = 0; i < filterlist.length - 1; i++) {
                  //   return Column(
                  //       children: [Text(filterlist[i])]);
                  // }
                  return ListTile(title: Text(filterlist[index]));
                });
          })
    ]);
  }
}
