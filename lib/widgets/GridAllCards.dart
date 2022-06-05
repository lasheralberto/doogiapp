import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridAllCards extends StatelessWidget {
  var title;
  var image;
  var gender;

  GridAllCards(
      {Key? key,
      required this.image,
      required this.title,
      required this.gender})
      : super(key: key);

  Widget build(BuildContext context) {
    return Stack(children: [
      Card(
          elevation: 6,
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(22), //bordes interiores
            child: Stack(children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(image as String), //varImg.url
                        fit: BoxFit.cover)),
                //child:
              ),
            ]),
          )),
      Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            IconTheme(
              data: IconThemeData(color: gender == 'Male' ? Colors.blue : Colors.pink ),
              child: Icon(gender == 'Male' ? Icons.male_rounded : Icons.female_rounded)),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),
      ),
    ]);
  }
}
