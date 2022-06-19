// ignore_for_file: file_names, camel_case_types

import 'package:ebook/widgets/DogsAdoptionList.dart';
import 'package:ebook/widgets/GridAllCards.dart';
import 'package:ebook/widgets/TomTomMap.dart';
import 'package:ebook/widgets/big_text.dart';
import 'package:ebook/widgets/filterGridList.dart';
import 'package:ebook/widgets/longPressGrid.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart' as getwid;
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class gridListDogs extends StatefulWidget {
  var lat;
  var long;
  var city;
  var mail;
  gridListDogs(
      {Key? key,
      required this.lat,
      required this.long,
      this.city,
      required this.mail})
      : super(key: key);

  @override
  State<gridListDogs> createState() => _gridListDogsState();
}

class _gridListDogsState extends State<gridListDogs> {
  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    const Widget emptyBlock = GridAllCardsShimmer();

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: const Text('Filter_but'),
            child: const Icon(
              Icons.filter_list_alt,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FilterGridList(),
                  ));
              // do something
            },
          ),
          FloatingActionButton(
            heroTag: const Text('Refresh_but'),
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                //fetchData(AppConstants.APIBASE_URL);
                getTodo(widget.mail);
              });
              // do something
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
          ),
          Wrap(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 4),
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.map),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TomTomMap(lat: widget.lat, long: widget.long),
                        ));
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text('Adopt'),
      ),
      body: FutureBuilder<List<ParseObject>>(
          future: getAllDogs(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                  // child: getwid.GFShimmer(
                  //child: emptyBlock,
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error..."),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No Data..."),
                  );
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      //*************************************
                      //Get Parse Object Values
                      final varTodo = snapshot.data![index];
                      final varTitle = varTodo.get<String>('title')!;
                      final varBreed = varTodo.get<String>('Breed');
                      final varAge = varTodo.get<String>('Age');
                      final varImg = varTodo.get<ParseFileBase>('DogImg')!;
                      final varDogDesc = varTodo.get<String>('DogDescription')!;
                      final varGender = varTodo.get<String>('Gender')!;
                      final varCity = varTodo.get<String>('CityName')!;
                      final varCountryName =
                          varTodo.get<String>('CountryName')!;

                      //*************************************
                      return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return LongPressGridCard(
                                    index: index,
                                    Age: varAge,
                                    title: varTitle,
                                    img: varImg,
                                    breed: varBreed,
                                    description: varDogDesc,
                                  );
                                });
                          },
                          child: GridAllCards(
                              image: varImg.url,
                              title: varTitle,
                              gender: varGender,
                              city: varCity,
                              country: varCountryName));
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 264,
                    ),
                  );
                }
            }
          }),
    );
  }
}

Future<List<ParseObject>> getAllDogs() async {
  await Future.delayed(const Duration(seconds: 2), () {});
  QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject('Todo'));
  final ParseResponse apiResponse = await queryTodo.query();

  if (apiResponse.success && apiResponse.results != null) {
    return apiResponse.results as List<ParseObject>;
  } else {
    return [];
  }
}

Future<void> updateTodo(String id, bool done) async {
  await Future.delayed(const Duration(seconds: 1), () {});
  var todo = ParseObject('Todo')
    ..objectId = id
    ..set('done', done);
  await todo.save();
}

Future<void> deleteTodo(String id) async {
  await Future.delayed(const Duration(seconds: 1), () {});
  var todo = ParseObject('Todo')..objectId = id;
  await todo.delete();
}
