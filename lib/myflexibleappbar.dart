import 'package:flutter/material.dart';
import 'package:pastore_app/style.dart';
import 'package:url_launcher/url_launcher.dart';

class MyFlexiableAppBar extends StatelessWidget {
  final double appBarHeight = 66.0;

  const MyFlexiableAppBar();


  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final headerTextStyle = TextStyle(
        color: AppTheme.darkBlue, fontSize: 27.0, fontWeight: FontWeight.w600);

    final regularTextStyle = TextStyle(
        color: AppTheme.nearlyBlack,
        fontSize: 15.0,
        fontWeight: FontWeight.w400);

    _launchTELBI() async {
      const tel = 'tel:+390158123128';
      if (await canLaunch(tel)) {
        await launch(tel);
      } else {
        throw 'Impossibile chiamare il numero $tel';
      }
    }

    _launchTELVC() async {
      const tel = 'tel:+390161294638';
      if (await canLaunch(tel)) {
        await launch(tel);
      } else {
        throw 'Impossibile chiamare il numero $tel';
      }
    }

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      child: new Center(
        child: Container(
          //color:Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.location_city),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    //color:Colors.red,
                    child:
                        new Text("Pastore Autoveicoli", style: headerTextStyle),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    //color:Colors.red,
                    child: new Text("Via Milano, 445 - Vigliano Biellese (BI)",
                        style: regularTextStyle),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.phone),
                  Container(
                    //color:Colors.red,
                    child: new FlatButton(
                      onPressed: _launchTELBI,
                      child: Text(
                        "0158123128",
                        style: regularTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    //color:Colors.red,
                    child: new Text("Via Giuseppe Cominetti, 1 - Vercelli (VC)",
                        style: regularTextStyle),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.phone),
                  Container(
                    //color:Colors.red,
                    child: new FlatButton(
                      onPressed: _launchTELVC,
                      child: Text(
                        "0161294638",
                        style: regularTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        //  SizedBox(height: 20.0),
      ),
      decoration: new BoxDecoration(color: AppTheme.notWhite),
    );
  }
}
