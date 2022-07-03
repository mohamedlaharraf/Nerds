import 'package:flutter/material.dart';
import 'package:nerds/custom/BorderIcon.dart';
import 'package:nerds/sample_data.dart';
import 'package:nerds/screens/DetailPage.dart';
import 'package:nerds/utils/constants.dart';
// import 'package:nerds/utils/custom_functions.dart';
import 'package:nerds/utils/widget_functions.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(30),
              Padding(
                padding: sidePadding,
                child: Text(
                  "Nerds",
                  style: themeData.textTheme.headline1,
                ),
              ),
              addVerticalSpace(10),
              Padding(
                padding: sidePadding,
                child: Text(
                  "Nerds est une application pour les étudiants qui veulent enrechire leur cultures dans le domaine d'IT.",
                  style: themeData.textTheme.bodyText2,
                ),
              ),
              Padding(
                  padding: sidePadding,
                  child: Divider(
                    height: 25,
                    color: COLOR_GREY,
                  )),
              addVerticalSpace(10),
              Expanded(
                child: Padding(
                  padding: sidePadding,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      itemCount: RE_DATA.length,
                      itemBuilder: (context, index) {
                        return ArticleItem(
                          itemData: RE_DATA[index],
                        );
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class ArticleItem extends StatelessWidget {
  final dynamic itemData;
  const ArticleItem({this.itemData});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailPage(
                  itemData: itemData,
                )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(itemData["image"])),
              ],
            ),
            addVerticalSpace(15),
            Row(
              children: [
                Text(
                  "${itemData["name"]}",
                  style: themeData.textTheme.headline1,
                ),
                addHorizontalSpace(10),
                Text(
                  "${itemData["address"]}",
                  style: themeData.textTheme.bodyText2,
                )
              ],
            ),
            addVerticalSpace(10),
            Text(
              "${itemData["Applications"]} Applications / ${itemData["Domaines"]} Domaines / ${itemData["area"]} Lectures",
              style: themeData.textTheme.headline5,
            )
          ],
        ),
      ),
    );
  }
}
