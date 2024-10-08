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
  String? _mySelectionFeat1 = 'Barking';
  String? _mySelectionFeat2 = 'Shedding';
  String? _mySelectionFeat3 = 'Grooming';
  double? _mySelectionValue1 = 1.0;
  double? _mySelectionValue2 = 1.0;
  double? _mySelectionValue3 = 1.0;
  var responsePred;
  List<dynamic> MLmodelList = [];
  bool ShowDogCard = false;
  bool ShowLoader = false;
  var idxBreedListPredicted;
  var accuracyPred;

  void initState() {
    super.initState();
  }

  Future<String?> postML(String? feat1, String? feat2, String? feat3,
      double? val1, double? val2, double? val3) async {
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
      var accuracy = map2['accuracy'];

      setState(() {
        responsePred = responsePredicted;
        ShowDogCard = true;
        idxBreedListPredicted = idxPredicted;
        ShowLoader = false;
        accuracyPred = accuracy;
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
      body: SingleChildScrollView(
        child: Column(
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
                        items: featList2
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
                        items: featList2
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
                        items: featList2
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
                  setState(() {
                    ShowDogCard = false;
                    ShowLoader = true;
                  });

                  await postML(
                      mapeoFeaturesList[_mySelectionFeat1],
                      mapeoFeaturesList[_mySelectionFeat2],
                      mapeoFeaturesList[_mySelectionFeat3],
                      _mySelectionValue1,
                      _mySelectionValue2,
                      _mySelectionValue3);
                }),
                child: Text('Post')),
            ShowDogCard == false && ShowLoader == false
                ? const Center(
                    child: Text('Please select features and values'),
                  )
                : ShowDogCard == false && ShowLoader == true
                    ? const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            child: ListCard(
                              screen: 'ML',
                              doglist: BreedList,
                              index: idxBreedListPredicted,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Accuracy of prediction: ${ accuracyPred.toStringAsFixed(2)} %'),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}

Map<String, String> mapeoFeaturesList = {
 "Good with children" : "good_with_children",
 "Good with other dogs": "good_with_other_dogs",
  "Shedding":"shedding",
  "Grooming":"grooming",
  "Good with strangers": "good_with_strangers",
  "Drooling":"drooling",
   "Playfulness" : "playfulness",
  "Protectiviness" : "protectiveness" ,
  "Trainability" : "trainability",
  "Energy" : "energy",
  "Barking" : "barking"
};
final List featList2=[
  "Good with children",
  "Good with other dogs",
  "Shedding",
  "Grooming",
  "Good with strangers",
  "Drooling",
  "Playfulness",
  "Protectiviness",
  "Trainability",
  "Energy",
  "Barking"
];

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
