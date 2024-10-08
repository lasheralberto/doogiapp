// ignore_for_file: file_names, camel_case_types

//https://app.brandmark.io/v3/

import 'dart:ffi';

import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/widgets/DogsAdoptionList.dart';
import 'package:ebook/widgets/GridAllCards.dart';
import 'package:ebook/widgets/TomTomMap.dart';
import 'package:ebook/widgets/big_text.dart';
import 'package:ebook/widgets/filterGridList.dart';
import 'package:ebook/widgets/longPressGrid.dart';
import 'package:ebook/widgets/searchBarUi.dart';
import 'package:flutter/material.dart';
import 'package:ebook/models/searchbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:getwidget/getwidget.dart' as getwid;
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ebook/widgets/filterGridList.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<ParseObject>>? futuregetalldogs;
  late SearchBar searchBar;
  var varSelectedFilterAge;
  var varSelectedFilterAgeStart;
  var varSelectedFilterAgeEnd;
  bool isFiltering = false;
  List<dynamic> snapList = [];
  List<dynamic> snapListFiltered = [];
  RangeValues _rangeValues = RangeValues(0.0, 19.0);

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: const Text(
          'Breed',
        ),
        elevation: 8,
        //centerTitle: true,
        //backgroundColor: Colors.white,
        //shape: RoundedRectangleBorder(borderRadius:  BorderRadius.vertical(bottom: Radius.circular(30))),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_alt_rounded,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) => AlertDialog(
                        title: const Text('Filter'),
                        content: SizedBox(
                          child: Card(
                            child: Column(
                              children: [
                                Text('Age'),
                                RangeSlider(
                                  values: _rangeValues,
                                  divisions: 20,
                                  labels: RangeLabels(
                                      _rangeValues.start.round().toString(),
                                      _rangeValues.end.round().toString()),
                                  onChanged: (value) {
                                    _rangeValues = value;
                                    setState(() {
                                      isFiltering = false;

                                      varSelectedFilterAgeStart = value.start;
                                      varSelectedFilterAgeEnd = value.end;
                                    });
                                  },
                                  min: 0.0,
                                  max: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            child: const Text('Apply'),
                            onPressed: () {
                              setState(() {
                                isFiltering = true;
                                snapListFiltered = snapList
                                    .where((element) =>
                                        element['Age'] >=
                                            varSelectedFilterAgeStart &&
                                        element['Age'] <=
                                            varSelectedFilterAgeEnd)
                                    .toList();
                              });
                              Navigator.of(context).pop([
                                varSelectedFilterAgeStart,
                                varSelectedFilterAgeEnd
                              ]);
                            },
                          ),
                          ElevatedButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  });
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
          searchBar.getSearchAction(context),
        ]);
  }

  List<dynamic>? _filteredDogList = [];
  set filter(String value) {
    if (value.isEmpty) {
      _filteredDogList = GridAllDogsList;
    } else {
      String filter = value.toLowerCase();

      //Si estamos filtrando,
      _filteredDogList = snapList
          .where((dog) =>
              (dog['title'].toLowerCase().contains(filter)) |
              (dog['CityName'].toLowerCase().contains(filter)) |
              (dog['Breed'].toLowerCase().contains(filter)))
          .toList();
    }
  }

  @override
  void initState() {
    super.initState();
    futuregetalldogs = getAllDogs();
  }

  _gridListDogsState() {
    searchBar = SearchBar(
        setState: setState,
        buildDefaultAppBar: buildAppBar,
        onCleared: () {
          setState(() {
            filter = '';
          });
        },
        onChanged: (String value) {
          setState(() {
            filter = value;
          });
        },
        onClosed: () {
          setState(() {
            filter = '';
          });
        });
    filter = '';
  }

  @override
  Widget build(BuildContext context) {
    const Widget emptyBlock = GridAllCardsShimmer();

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      //PreferredSize(
      //preferredSize:
      //AppBar().preferredSize, child: searchBarUI()),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<ParseObject>>(
          future: futuregetalldogs,
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
                    itemCount: _filteredDogList!.isEmpty
                        ? snapshot.data.length
                        : _filteredDogList!.length, // snapshot.data!.length,
                    itemBuilder: (context, index) {
                      //*************************************
                      snapList = snapshot.data;
                      //Get Parse Object Values
                      final varTodo = snapshot.data![index];
                      final varTitle = varTodo.get<String>('title')!;
                      final varBreed = varTodo.get<String>('Breed');
                      final varAge = varTodo.get<int>('Age');
                      final varImg = varTodo.get<ParseFileBase>('DogImg')!;
                      final varDogDesc = varTodo.get<String>('DogDescription')!;
                      final varGender = varTodo.get<String>('Gender')!;
                      final varCity = varTodo.get<String>('CityName')!;
                      final varCountryName =
                          varTodo.get<String>('CountryName')!;
                      final varlat = varTodo.get<double>('latitude');
                      final varlong = varTodo.get<double>('longitude');

                      //*************************************
                      return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return _filteredDogList!.isEmpty
                                      ? LongPressGridCard(
                                          index: index,
                                          Age: varAge,
                                          title: varTitle,
                                          img: varImg,
                                          breed: varBreed,
                                          description: varDogDesc,
                                          lat: varlat,
                                          long: varlong)
                                      : LongPressGridCard(
                                          index: index,
                                          Age: _filteredDogList![index]['Age']
                                              .toString(),
                                          title: _filteredDogList![index]
                                                  ['title']
                                              .toString(),
                                          img: _filteredDogList![index]
                                              ['DogImg'],
                                          breed: _filteredDogList![index]
                                                  ['Breed']
                                              .toString(),
                                          description: _filteredDogList![index]
                                                  ['DogDescription']
                                              .toString(),
                                          lat: _filteredDogList![index]
                                                  ['latitude']
                                              .toString(),
                                          long: _filteredDogList![index]
                                                  ['longitude']
                                              .toString(),
                                        );
                                });
                          },
                          child: _filteredDogList!.isEmpty
                              ? GridAllCards(
                                  image: varImg.url,
                                  title: varTitle,
                                  gender: varGender,
                                  city: varCity,
                                  country: varCountryName)
                              : GridAllCards(
                                  image: _filteredDogList![index]['DogImg']
                                      ['url'],
                                  title: _filteredDogList![index]['title']
                                      .toString(),
                                  gender: _filteredDogList![index]['Gender'],
                                  city: _filteredDogList![index]['CityName'],
                                  country: _filteredDogList![index]
                                      ['CountryName'],
                                ));
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
