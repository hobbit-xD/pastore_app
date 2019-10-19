import 'package:flutter/material.dart';
import 'package:pastore_app/style/style.dart';
import 'package:url_launcher/url_launcher.dart';

class MyFlexiableAppBar extends StatelessWidget {
  const MyFlexiableAppBar();

  @override
  Widget build(BuildContext context) {
    final regularTextStyle = TextStyle(
        color: AppTheme.nearlyBlack,
        fontSize: 20.0,
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

    _launchWEB() async {
      const url = 'http://www.pastoreautoveicoli.it';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Impossibile aprire il sito $url';
      }
    }

    _launchMapsBI() async {
      const url =
          'https://www.google.com/maps/search/?api=1&query=45.5630631,8.1245816&query_place_id=ChIJmd2s0sAjhkcRVySyUXJaTIQ';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Impossibile aprire maps $url';
      }
    }

    _launchMapsVC() async {
      const url =
          'https://www.google.com/maps/search/?api=1&query=45.32164,8.3879313&query_place_id=ChIJg8q4d3BLhkcRnbN-q25KV4M';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Impossibile aprire maps $url';
      }
    }

    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(
              "assets/pastore-logo.png",
              height: 70.0,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 10.0),
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(7.0),
                  child: Icon(Icons.place, color: AppTheme.darkerBlue),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppTheme.orange),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: _launchMapsBI,
                  child: new Text("Biella",
                      style: regularTextStyle.copyWith(color: AppTheme.darkBlue,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 5.0),
                Container(
                    padding: EdgeInsets.all(7.0),
                    child: Icon(
                      Icons.phone,
                      color: AppTheme.darkerBlue,
                    ),
                    decoration: BoxDecoration(
                        color: AppTheme.orange, shape: BoxShape.circle)),
                SizedBox(width: 5.0),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: _launchTELBI,
                  child: Text(
                    "+39 015/8123128",
                    style: regularTextStyle.copyWith(fontSize: 17.0),
                  ),
                ),
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(7.0),
                  child: Icon(Icons.place, color: AppTheme.darkerBlue),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppTheme.orange),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: _launchMapsVC,
                  child: new Text("Vercelli",
                      style: regularTextStyle.copyWith(color: AppTheme.darkBlue,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                    padding: EdgeInsets.all(7.0),
                    child: Icon(
                      Icons.phone,
                      color: AppTheme.darkerBlue,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppTheme.orange)),
                SizedBox(width: 5.0),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: _launchTELVC,
                  child: Text(
                    "+39 0161/294638",
                    style: regularTextStyle.copyWith(fontSize: 17.0),
                  ),
                ),
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              children: <Widget>[
                Container(
                    child: Container(
                        padding: EdgeInsets.all(7.0),
                        child: Icon(
                          Icons.language,
                          color: AppTheme.darkerBlue,
                        )),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppTheme.orange)),
                SizedBox(width: 5.0),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: _launchWEB,
                  child: Text(
                    "www.pastoreautoveicoli.it",
                    style: regularTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: new BoxDecoration(color: AppTheme.notWhite),
    );
  }
}
