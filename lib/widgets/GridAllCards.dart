import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridAllCards extends StatelessWidget {
  var title;
  var image;
  GridAllCards({Key? key, required this.image, required this.title})
      : super(key: key);

  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(12),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
                width: double.infinity,
                height: 10,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(image as String), //varImg.url
                        fit: BoxFit.cover)),
                child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      title,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70))))));
  }
}
