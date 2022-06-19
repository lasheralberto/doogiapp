import 'package:flutter/material.dart';

class FilterGridList extends StatefulWidget {
  const FilterGridList({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterGridList> createState() => _FilterGridListState();
}

class _FilterGridListState extends State<FilterGridList> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: const Text('Filter')),
        body: FilterChip(
          pressElevation: 15,
          selectedColor: selected == false ? Colors.green : Colors.red,
          checkmarkColor: Colors.deepOrange,
          label: const Text("Chip Unselected"),
          selected: false,
          onSelected: (bool value) {
            selected = true;

            setState(() {
              selected = value;
            });
          },
        ),
      ),
    );
  }
}
