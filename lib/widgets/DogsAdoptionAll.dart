import 'package:ebook/widgets/gridListMyDogs.dart';
import 'package:flutter/material.dart';

class DogsAdoptionAll extends StatefulWidget {
  var lat;
  var long;

  DogsAdoptionAll({Key? key, required this.lat, required this.long})
      : super(key: key);

  @override
  State<DogsAdoptionAll> createState() => _DogsAdoptionAllState();
}

class _DogsAdoptionAllState extends State<DogsAdoptionAll> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  gridListDogs(lat: widget.lat, long:  widget.long,);
  }
}
