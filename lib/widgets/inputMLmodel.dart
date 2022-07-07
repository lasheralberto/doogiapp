import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class InputMLmodel extends StatefulWidget {
  const InputMLmodel({Key? key}) : super(key: key);

  @override
  State<InputMLmodel> createState() => _InputMLmodelState();
}

class _InputMLmodelState extends State<InputMLmodel> {
  String? _mySelectionFeat1 = 'barking';
  String? _mySelectionFeat2 = 'barking';
  String? _mySelectionFeat3 = 'barking';
  int? _mySelectionValue1 = 1;
  int? _mySelectionValue2 = 1;
  int? _mySelectionValue3 = 1;
  var responsePred;

  Future<http.Response> postML(String? feat1,String? feat2,String? feat3,int? val1,int? val2,int? val3) async {
    var map = <String?, int?>{};
    map[feat1] = val1;
    map[feat2] = val2;
    map[feat3] = val3;

    var client = http.Client();

    return client.post(
      Uri.parse(
          'https://dogsbreedapp.herokuapp.com/postml/$val1/$val2/$val3/$feat1/$feat2/$feat3'),
      //body: map,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prediction breed model')),
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                          hint: const Text('Select Feature 1'),
                          value: _mySelectionValue1,
                          onChanged: (int? newValue) {
                            setState(
                              () {
                                _mySelectionValue1 = newValue;
                              },
                            );
                          },
                          isDense: true,
                          items: featValues
                              .map((map) => DropdownMenuItem<int>(
                                  child: Text(map.toString()), value: map))
                              .toList()),
                    ),
                  ),
                ),
              ),
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
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                          hint: const Text('Select Feature 1'),
                          value: _mySelectionValue2,
                          onChanged: (int? newValue) {
                            setState(
                              () {
                                _mySelectionValue2 = newValue;
                              },
                            );
                          },
                          isDense: true,
                          items: featValues
                              .map((map) => DropdownMenuItem<int>(
                                  child: Text(map.toString()), value: map))
                              .toList()),
                    ),
                  ),
                ),
              ),
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
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                          value: _mySelectionValue3,
                          onChanged: (int? newValue) {
                            setState(
                              () {
                                _mySelectionValue3 = newValue;
                              },
                            );
                          },
                          isDense: true,
                          items: featValues
                              .map((map) => DropdownMenuItem<int>(
                                  child: Text(map.toString()), value: map))
                              .toList()),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: (() {
                    postML(
                        _mySelectionFeat1,
                        _mySelectionFeat2,
                        _mySelectionFeat3,
                        _mySelectionValue1,
                        _mySelectionValue2,
                        _mySelectionValue3);
                  }),
                  child: Text('Post')),
              Text(responsePred.toString())
            ],
          )),
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
