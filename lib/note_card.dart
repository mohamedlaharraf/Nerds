import 'dart:math';

import 'package:nerds/app_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color:
              AppStyle.cardsColor[Random().nextInt(AppStyle.cardsColor.length)],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "P. " + doc['nom'],
              style: AppStyle.mainTitle,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              "D. " + doc['prenom'],
              style: AppStyle.mainTitle,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              doc['date_save'],
              style: AppStyle.dateTitle,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "Age: " + doc['age'].toStringAsFixed(0).toString(),
              style: AppStyle.mainContent,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "Sexe: " + doc['sexe'].toString(),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ));
}
