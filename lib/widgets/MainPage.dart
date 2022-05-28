// ignore_for_file: unused_import, file_names, use_function_type_syntax_for_parameters
import 'package:ebook/models/dogsmodel.dart';
import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/models/searchbar.dart';
import 'package:ebook/widgets/ListCard.dart';
import 'package:ebook/widgets/constants.dart';
import 'package:ebook/widgets/foundSearchDog.dart';
import 'package:ebook/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ebook/pages/home/book_body.dart';
//import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/services.dart';
import 'big_text.dart';
import 'dimensions.dart';
import 'icon_and_text_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController textController = TextEditingController();
  List<dynamic> glossarListOnSearch = [];
  bool _firstSearch = true;
  final List<String> _filterList = [];
  String _query = '';

  @override
  void initState() {
    //_filterList.clear();
    super.initState();
    _filterList.isEmpty ? fetchData(AppConstants.APIBASE_URL) : _filterList;
  }

  _MainPageState() {
    textController.addListener(() {
      if (textController.text.isEmpty) {
        setState(() {
          _filterList.clear();
          _firstSearch = true;
          _query = '';
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = textController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.network(AppConstants.APPLOGO),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Text('MyApp')),
      backgroundColor: Colors.white,
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
                )
              ],
            ),
          ),
          Expanded(
            child: _firstSearch == true
                //textController.text.isEmpty
                ? const SingleChildScrollView(
                    child: 
                    BookPageBody(),
                  )
                : SingleChildScrollView(
                    child: 
                    foundDog(
                      filterlist: _filterList,
                      glossarlist: glossarListOnSearch,
                      query: _query,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
