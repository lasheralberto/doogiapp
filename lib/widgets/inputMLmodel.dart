import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputMLmodel extends StatefulWidget {
  const InputMLmodel({Key? key}) : super(key: key);

  @override
  State<InputMLmodel> createState() => _InputMLmodelState();
}

class _InputMLmodelState extends State<InputMLmodel> {
  String? _mySelectionFeat = 'barking';
  int? _mySelectionValue = 1;

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
                          value: _mySelectionFeat,
                          onChanged: (String? newValue) {
                            setState(
                              () {
                                _mySelectionFeat = newValue;
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
                          value: _mySelectionValue,
                          onChanged: (newValue) {
                            setState(
                              () {
                                _mySelectionValue = newValue as int?;
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
                          value: _mySelectionFeat,
                          onChanged: (String? newValue) {
                            setState(
                              () {
                                _mySelectionFeat = newValue;
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
                          value: _mySelectionValue,
                          onChanged: (newValue) {
                            setState(
                              () {
                                _mySelectionValue = newValue as int?;
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
                          value: _mySelectionFeat,
                          onChanged: (String? newValue) {
                            setState(
                              () {
                                _mySelectionFeat = newValue;
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
                          value: _mySelectionValue,
                          onChanged: (newValue) {
                            setState(
                              () {
                                _mySelectionValue = newValue as int?;
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
