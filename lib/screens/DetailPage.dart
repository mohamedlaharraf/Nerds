import 'package:flutter/material.dart';
import 'package:nerds/custom/BorderIcon.dart';
import 'package:nerds/utils/constants.dart';
// import 'package:nerds/utils/custom_functions.dart';
import 'package:nerds/utils/widget_functions.dart';

class DetailPage extends StatelessWidget {
  final dynamic itemData;
  const DetailPage({required this.itemData});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
      backgroundColor: COLOR_WHITE,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset(itemData["image"]),
                      Positioned(
                        width: size.width,
                        top: padding,
                        child: Padding(
                          padding: sidePadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: BorderIcon(
                                  padding: EdgeInsets.all(8.0),
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Icons.keyboard_backspace,
                                    color: COLOR_BLACK,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(padding),
                  Padding(
                    padding: sidePadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text("${formatCurrency(itemData["amount"])}",style: themeData.textTheme.headline1,),

                            Text(
                              "${itemData["name"]}",
                              style: themeData.textTheme.headline1,
                            ),
                            addVerticalSpace(5),
                            Text(
                              "${itemData["address"]}",
                              style: themeData.textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(padding),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        InformationTile(
                          content: "${itemData["area"]}",
                          name: "Lectures",
                        ),
                        InformationTile(
                          content: "${itemData["Applications"]}",
                          name: "Applications",
                        ),
                        InformationTile(
                          content: "${itemData["Domaines"]}",
                          name: "Domaines",
                        ),
                        InformationTile(
                          content: "${itemData["Evaluation"]}",
                          name: "Evaluation",
                        )
                      ],
                    ),
                  ),
                  addVerticalSpace(padding),
                  Padding(
                    padding: sidePadding,
                    child: Text(
                      itemData["description"],
                      textAlign: TextAlign.justify,
                      style: themeData.textTheme.bodyText2,
                    ),
                  ),
                  addVerticalSpace(20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InformationTile extends StatelessWidget {
  final String content;
  final String name;
  const InformationTile({required this.content, required this.name});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final double tileSize = size.width * 0.20;
    return Container(
      margin: const EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BorderIcon(
              padding: EdgeInsets.all(8.0),
              width: tileSize,
              height: tileSize,
              child: Text(
                content,
                style: themeData.textTheme.headline3,
              )),
          addVerticalSpace(15),
          Text(
            name,
            style: themeData.textTheme.headline6,
          )
        ],
      ),
    );
  }
}
