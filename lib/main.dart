import 'dart:math';

import 'package:flutter/material.dart';

List<String> images = [
  "assets/image_07.jpg",
  "assets/image_06.jpg",
  "assets/image_05.jpg",
  "assets/image_04.jpg",
  "assets/image_03.jpg",
  "assets/image_02.jpg",
  "assets/image_01.png"
];

List<String> titles = [
  "Hounted Ground",
  "Fallen In Love",
  "The Dreaming Moon",
  "Jack the Persian and the Black Castel",
];

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

var cardAspectRatio = 0.75;
var widgetAspectRatio = 0.9;

class _MyAppState extends State<MyApp> {
  var currentPageOffset = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPageOffset = controller.page;
      });
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Stack(
          children: <Widget>[
            CardScrollWidget(currentPageOffset),
            Positioned.fill(
              child: PageView.builder(
                itemCount: images.length,
                controller: controller,
                reverse: true,
                itemBuilder: (context, index) {
                  return Container(
//                    child: Image.asset(images[index]),
                      );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPageOffset;

  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPageOffset);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

//        print('width:${width},height:${height}');

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

//                print('primaryCardLeft:${primaryCardLeft},horizontalInset:${horizontalInset}');

        List<Widget> cardList = new List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPageOffset;

//          print('delta:${delta}');
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

//          print('start:${start}');

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(3.0, 6.0),
                    blurRadius: 10.0)
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Image.asset(images[i], fit: BoxFit.cover),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
