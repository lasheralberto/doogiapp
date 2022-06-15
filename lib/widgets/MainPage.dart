// ignore_for_file: unused_import, file_names, use_function_type_syntax_for_parameters
import 'package:ebook/models/dogsmodel.dart';
import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/models/searchbar.dart';
import 'package:ebook/widgets/ListCard.dart';
import 'package:ebook/widgets/constants.dart';
import 'package:ebook/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:ebook/pages/home/book_body.dart';
import 'package:flutter/services.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'big_text.dart';
import 'dimensions.dart';
import 'icon_and_text_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<List<dynamic>>? futureData;
  TextEditingController textController = TextEditingController();
  late SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return AppBar(title: const Text('Breed List'), actions: [
      searchBar.getSearchAction(context),
    ]);
  }

  List<dynamic> _filteredBreedList = [];

  void set filter(String value) {
    if (value.isEmpty) {
      _filteredBreedList = BreedList;
    } else {
      String filter = value.toLowerCase();
      _filteredBreedList =
          BreedList.where((dog) => dog.breed.toLowerCase().contains(filter))
              .toList();
    }
  }

  @override
  void initState() {
    super.initState();
    futureData = fetchData(AppConstants.APIBASE_URL);
  }

  _MainPageState() {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width -
                        (MediaQuery.of(context).size.width / 3.5),
                    height: 0,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: futureData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: _filteredBreedList.isEmpty
                              ? BreedList.length
                              : _filteredBreedList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SingleChildScrollView(
                                child: (_filteredBreedList.isEmpty)
                                    ? BookPageBody(
                                        breedlist: BreedList,
                                        index: index,
                                      )
                                    : BookPageBody(
                                        breedlist: _filteredBreedList,
                                        index: index,
                                      ));
                          });
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return SafeArea(child: SizedBox(
                      height: 30,
                      child: CircularProgressIndicator()));
                  })),
        ],
      ),
    );
  }
}
