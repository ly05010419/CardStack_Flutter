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

//List<String> images = [
//  "assets/image_07.jpg",
//  "assets/image_06.jpg1",
//  "assets/image_05.jpg1",
//  "assets/image_04.jpg1",
//  "assets/image_03.jpg1",
//  "assets/image_02.jpg1",
//  "assets/image_01.png1"
//];

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

class _MyAppState extends State<MyApp> {
  var currentPageOffset = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var height = width * 1.1;

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
            new Container(
              width: width,
              height: height,
              child: Stack(
                children: createList(currentPageOffset, width, height),
              ),
            ),
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

  List<Widget> createList(var currentPageOffset, var width, var height) {
    var verticalInset = 20.0;

    var widthOfCard = width * 0.7;

    var primaryCardToLeft = 80;
    var horizontalInset = 40;

    List<Widget> cardList = new List();

    for (var i = 0; i < images.length; i++) {
      var delta = i - currentPageOffset;

      bool isOnRight = delta > 0;

      var start = max(
          primaryCardToLeft - horizontalInset * -delta * (isOnRight ? 15 : 1),
          0.0);

      var cardItem = Positioned.directional(
        top: verticalInset * max(-delta, 0.0),
        bottom: verticalInset * max(-delta, 0.0),
        start: start,
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: widthOfCard,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(images[i], fit: BoxFit.cover),
            ),
          ),
        ),
      );
      cardList.add(cardItem);
    }

    return cardList;
  }
}
