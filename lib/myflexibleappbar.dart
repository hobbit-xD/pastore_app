import 'package:flutter/material.dart';
import 'package:pastore_app/style.dart';
import 'package:url_launcher/url_launcher.dart';

class MyFlexiableAppBar extends StatelessWidget {
  const MyFlexiableAppBar();

  @override
  Widget build(BuildContext context) {
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
                Icon(Icons.place),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: _launchMapsBI,
                  child: new RichText(
                    text: TextSpan(
                        text: "Vigliano B.se",
                        style: regularTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: " - Via Milano,445",
                              style: regularTextStyle)
                        ]),
                  ),
                ),
                SizedBox(width: 5.0),
                Icon(Icons.phone),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: _launchTELBI,
                  child: Text(
                    "0158123128",
                    style: regularTextStyle,
                  ),
                ),
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              children: <Widget>[
                Icon(Icons.place),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: _launchMapsVC,
                  child: new RichText(
                    text: TextSpan(
                        text: "Vercelli",
                        style: regularTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: " - Via Giuseppe Cominetti, 1",
                              style: regularTextStyle)
                        ]),
                  ),
                ),
                Icon(Icons.phone),
                SizedBox(width: 5.0),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: _launchTELVC,
                  child: Text(
                    "0161294638",
                    style: regularTextStyle,
                  ),
                ),
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              children: <Widget>[
                Icon(Icons.language),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: _launchWEB,
                  child: Text(
                    "www.pastoreautoveicoli.it",
                    style: regularTextStyle.copyWith(fontSize: 18.0),
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
