import 'dart:async';
import 'dart:convert';

import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/models/postMLModel.dart';
import 'package:ebook/pages/home/book_body.dart';
import 'package:ebook/widgets/ListCard.dart';
import 'package:ebook/widgets/PopularDetailsBreedSimplified.dart';
import 'package:ebook/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_sliders/sliders.dart';

class InputMLmodel extends StatefulWidget {
  List<dynamic> breedlist;
  InputMLmodel({Key? key, required this.breedlist}) : super(key: key);

  @override
  State<InputMLmodel> createState() => _InputMLmodelState();
}

class _InputMLmodelState extends State<InputMLmodel> {
  String? _mySelectionFeat1 = 'barking';
  String? _mySelectionFeat2 = 'barking';
  String? _mySelectionFeat3 = 'barking';
  double? _mySelectionValue1 = 1.0;
  double? _mySelectionValue2 = 1.0;
  double? _mySelectionValue3 = 1.0;
  var responsePred;
  List<dynamic> MLmodelList = [];
  bool ShowDogCard = false;
  Future<String>? futureML;
  var idxBreedListPredicted;
  SfRangeValues _values = const SfRangeValues(1.0, 5.0);

  void initState() {
    super.initState();
  }

  Future<String?> postML(String? feat1, String? feat2, String? feat3, double? val1,
      double? val2, double? val3) async {
    var map = <String?, double?>{};
    map[feat1] = val1;
    map[feat2] = val2;
    map[feat3] = val3;

    var client = http.Client();

    final response = await client.post(
      Uri.parse(
          'https://dogsbreedapp.herokuapp.com/postml/$val1/$val2/$val3/$feat1/$feat2/$feat3'),
      //body: map,
    );
    if (response.statusCode == 200) {
      var map = json.decode(response.body);
      Map<dynamic, dynamic> map2 = map[0];
      var responsePredicted = map2['predicted_breeds'];
      var idxPredicted = map2['predicted_value'];

      setState(() {
        responsePred = responsePredicted;
        ShowDogCard = true;
        idxBreedListPredicted = idxPredicted;
      });

      return responsePredicted;
    } else {
      throw Exception('Failed to load datta');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prediction breed model')),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Expanded(
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      hint: const Text('Select Feature 1'),
                      value: _mySelectionFeat1,
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            _mySelectionFeat1 = newValue;
                          },
                        );
                      },
                      isDense: true,
                      items: featList
                          .map((map) => DropdownMenuItem<String>(
                              child: Text(map), value: map))
                          .toList()),
                ),
              ),
            ),
          ),
          SfSlider(
            min: 1,
            max: 5,
            value: _mySelectionValue1,
            interval: 1,
            showLabels: true,
            onChanged: (dynamic value) {
              setState(() {
                _mySelectionValue1 = value;
              });
            },
          ),
          SizedBox(height: 20),

          Align(
            alignment: AlignmentDirectional.topStart,
            child: Expanded(
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      hint: const Text('Select Feature 1'),
                      value: _mySelectionFeat2,
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            _mySelectionFeat2 = newValue;
                          },
                        );
                      },
                      isDense: true,
                      items: featList
                          .map((map) => DropdownMenuItem<String>(
                              child: Text(map), value: map))
                          .toList()),
                ),
              ),
            ),
          ),
                    SfSlider(
            min: 1,
            max: 5,
            value: _mySelectionValue2,
            interval: 1,
            showLabels: true,
            onChanged: (dynamic value) {
              setState(() {
                _mySelectionValue2 = value;
              });
            },
          ),

          SizedBox(height: 20),

          Align(
            alignment: AlignmentDirectional.topStart,
            child: Expanded(
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      hint: const Text('Select Feature 1'),
                      value: _mySelectionFeat3,
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            _mySelectionFeat3 = newValue;
                          },
                        );
                      },
                      isDense: true,
                      items: featList
                          .map((map) => DropdownMenuItem<String>(
                              child: Text(map), value: map))
                          .toList()),
                ),
              ),
            ),
          ),
          SfSlider(
            min: 1,
            max: 5,
            value: _mySelectionValue3,
            interval: 1,
            showLabels: true,
            onChanged: (dynamic value3) {
              setState(() {
                _mySelectionValue3 = value3;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: (() async {
                await postML(
                    _mySelectionFeat1,
                    _mySelectionFeat2,
                    _mySelectionFeat3,
                    _mySelectionValue1,
                    _mySelectionValue2,
                    _mySelectionValue3);
              }),
              child: Text('Post')),

          ShowDogCard == false
              ? const Center(
                  child: Text('Please select features and values'),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListCard(
                    doglist: BreedList,
                    index: idxBreedListPredicted,
                  ),
                ),
        ],
      ),
    );
  }
}

final List featList = [
  "good_with_children",
  "good_with_other_dogs",
  "shedding",
  "grooming",
  "good_with_strangers",
  "drooling",
  "playfulness",
  "protectiveness",
  "trainability",
  "energy",
  "barking",
];

final List featValues = [0, 1, 2, 3, 4, 5];
