import 'package:nerds/insertData.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  dynamic _selectedIndex = {};

  final CarouselController _carouselController = CarouselController();
  final List<dynamic> _products = [
    {
      'title': 'Machine learning\n(Prédiction)',
      'image': 'assets/sent.jpg',
      'description': 'On se base sur des données'
    },
    {
      'title': 'Modéle 3D\nLa réalité augmentée',
      'image': 'assets/photo2.jpg',
      'description': 'Ajouter des éléments virtuels'
    },
    {
      'title': 'Valvulopathie aortique \nRAC',
      'image': 'assets/photo4.jpg',
      'description': 'Auto calcule du Diametre RAC'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // navigation for blocs (calc)
      height: double.infinity,
      width: double.infinity,
      child: Scaffold(
        floatingActionButton: _selectedIndex.length > 0
            ? FloatingActionButton(
                onPressed: () {
                  if (_selectedIndex['title'] ==
                      'Valvulopathie aortique \nRAC') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return InsertData();
                        },
                      ),
                    );
                  }
                },
                child: const Icon(
                  Icons.arrow_right_alt,
                ),
                backgroundColor: Colors.blueAccent,
              )
            : null,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                  height: 450.0,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.70,
                  enlargeCenterPage: true,
                  pageSnapping: true,
                  onPageChanged: (index, reason) {
                    setState(() {});
                  }),
              items: _products.map((movie) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_selectedIndex == movie) {
                            _selectedIndex = {};
                          } else {
                            _selectedIndex = movie;
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20),
                            border: _selectedIndex == movie
                                ? Border.all(color: Colors.white, width: 3)
                                : null,
                            boxShadow: _selectedIndex == movie
                                ? [
                                    BoxShadow(
                                        color: Colors.red.shade100,
                                        blurRadius: 30,
                                        offset: Offset(0, 10))
                                  ]
                                : [
                                    BoxShadow(
                                        color: Colors.white.withOpacity(0.2),
                                        blurRadius: 20,
                                        offset: Offset(0, 5))
                                  ]),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 320,
                                margin: EdgeInsets.only(top: 10),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.asset(movie['image'],
                                    fit: BoxFit.cover),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                movie['title'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                movie['description'],
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList()),
        ),
      ),
    );
  }
}
