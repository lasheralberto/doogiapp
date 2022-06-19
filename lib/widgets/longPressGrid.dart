import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/widgets/ListCard.dart';
import 'package:ebook/widgets/PopularDetailsBreedSimplified.dart';
import 'package:ebook/widgets/personalDogDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../pages/books/popularbooksdetails.dart';
import 'big_text.dart';

class LongPressGridCard extends StatelessWidget {
  final int index;
  final String Age;
  final String title;
  final ParseFile img;
  final String breed;
  final String? description;

  LongPressGridCard(
      {Key? key,
      required this.index,
      required this.Age,
      required this.title,
      required this.img,
      required this.breed,
      this.description})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          shadowColor: Colors.blue,
          elevation: 16,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                Center(child: BigText(text: '$title')),
                const SizedBox(height: 20),
                // Center(
                //     child: BigText(
                //   text: 'Age: $Age ',
                // )),
                const SizedBox(height: 20),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PopularBookDetailsSimplified(
                                  index: 0,
                                  doglist:
                                      BreedList.where((dog) => dog.breed == breed)
                                          .toList()))
                          //inputlist.where((o) => o['category_id'] == '1').toList();
                          );
                    },
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Icon(Icons.info), Text('Breed info')],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => personalDogDetail(
                              screen: 'All',
                              title: title,
                              Age: Age,
                              description: description,
                              img: img.url,
                              breed: breed,
                            ),
                          ));
                    },
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.description),
                          Text('Dog Description')
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
