import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterGridList extends StatelessWidget {
  final ValueChanged<String> onChanged;
  var valueSelectedStart;
  var valueSelectedEnd;

  FilterGridList(
      {Key? key,
      required this.onChanged,
      this.valueSelectedStart,
      this.valueSelectedEnd})
      : super(key: key);

  bool selected = false;
  var valueSelected;

  RangeValues _rangeValues = RangeValues(0.0, 19.0);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        child: Card(
          child: Column(
            children: [
              Text('Age'),
              RangeSlider(
                values: _rangeValues,
                divisions: _rangeValues.end.toInt(),
                labels: RangeLabels(_rangeValues.start.round().toString(),
                    _rangeValues.end.round().toString()),
                onChanged: (value) {},
                min: 0.0,
                max: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
