// ignore_for_file: file_names

import 'dart:convert';

import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

class CostLivingTable extends StatelessWidget {
  final int index;
  const CostLivingTable({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // future: fetchData(AppConstants.APIBASE_URL),
        // builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        //   if (snapshot.hasData) {
        //     return Scaffold(
        //         body: DataTable(columns: [
        //       //for (var item in hotelsList[index].costOfLiving!)
        //       DataColumn(
        //         label: Text(snapshot.data!),
        //       )
        //     ], rows: const <DataRow>[
        //       DataRow(
        //         cells: <DataCell>[
        //           DataCell(Text('Sarah')),
        //           DataCell(Text('19')),
        //           DataCell(Text('Student')),
        //         ],
        //       ),
        //       DataRow(
        //         cells: <DataCell>[
        //           DataCell(Text('Janine')),
        //           DataCell(Text('43')),
        //           DataCell(Text('Professor')),
        //         ],
        //       ),
        //       DataRow(
        //         cells: <DataCell>[
        //           DataCell(Text('William')),
        //           DataCell(Text('27')),
        //           DataCell(Text('Associate Professor')),
        //         ],
        //       ),
        //     ]));
        //   } else {
        //     if (snapshot.hasError) {
        //       return Center(child: Text('Error: ${snapshot.error}'));

        //     }
        //   }
        );
  }
}
