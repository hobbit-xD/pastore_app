import 'package:flutter/material.dart';
import 'package:pastore_app/style.dart';

class MyAppBar extends StatelessWidget {
  final double barHeight = 66.0;

  const MyAppBar();

  @override
  Widget build(BuildContext context) {

    final headerTextStyle = TextStyle(
        color: AppTheme.darkerBlue, fontSize: 30.0, fontWeight: FontWeight.w600);


    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child:Text(
                'Pastore Autoveicoli',
                style: headerTextStyle
              ),
            ),
          Container(
            child: Icon(
                Icons.person,
                color: AppTheme.darkerBlue,
              ),
            ),
        ],
      ),
    );
  }
}
