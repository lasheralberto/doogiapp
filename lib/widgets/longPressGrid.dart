import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/widgets/PopularDetailsBreedSimplified.dart';
import 'package:ebook/widgets/personalDogDetail.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'big_text.dart';

class LongPressGridCard extends StatelessWidget {
  final int index;
  final String Age;
  final String title;
  final ParseFile img;
  final String breed;
  final String? description;
  var lat;
  var long;

  LongPressGridCard(
      {Key? key,
      required this.index,
      required this.Age,
      required this.title,
      required this.img,
      required this.breed,
      this.description,
      this.lat,
      this.long})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center, //or choose another Alignment
      child: SizedBox(
        width: MediaQuery.of(context).size.width/1.5,
        height: MediaQuery.of(context).size.height/2.5 ,
        child: Card(
              semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
          //margin: EdgeInsets.all(35),
          shadowColor: Colors.blue,
          elevation: 16,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
          child: SafeArea(
            //minimum: EdgeInsets.all(100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                Center(child: BigText(text: title)),
                const SizedBox(height: 20),
                // Center(
                //     child: BigText(
                //   text: 'Age: $Age ',
                // )),
                const SizedBox(height: 20),
                Center(
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PopularBookDetailsSimplified(
                                      index: 0,
                                      doglist: BreedList.where(
                                              (dog) => dog.breed == breed)
                                          .toList())));
                    },
                    label: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Icon(Icons.read_more_sharp),
                        ),
                        Text("Breed info")
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: FloatingActionButton.extended(
                    onPressed: () {
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
                              lat: lat,
                              long: long,
                            ),
                          ));
                    },
                    label: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Icon(Icons.info),
                        ),
                        Text("Dog info")
                      ],
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
