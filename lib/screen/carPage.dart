import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pastore_app/database/favorites_database.dart';
import 'package:pastore_app/style/style.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pastore_app/car.dart';

class CarPage extends StatefulWidget {
  final Car car;
  final MyDatabase myDatabase;

  CarPage(this.car, this.myDatabase);

  @override
  State<StatefulWidget> createState() => CarPageState(car, myDatabase);
}

class CarPageState extends State<CarPage> {
  final Car car;
  final MyDatabase myDatabase;
  ScrollController _controller;

  CarPageState(this.car, this.myDatabase);

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final headerTextStyle = TextStyle(
        color: AppTheme.darkBlue, fontSize: 15.0, fontWeight: FontWeight.w600);

    final regularTextStyle = TextStyle(
        color: AppTheme.nearlyBlack,
        fontSize: 14.0,
        fontWeight: FontWeight.w400);

    List<dynamic> listDetails = car.details;

    final _riferimento = new Row(
      children: <Widget>[
        new Text("Rif: ",
            style: regularTextStyle.copyWith(
                color: AppTheme.darkBlue, fontWeight: FontWeight.bold)),
        new Text(car.rif ?? '-',
            style: regularTextStyle.copyWith(fontWeight: FontWeight.normal))
      ],
    );

    final _anno = new Row(
      children: <Widget>[
        new Text("Anno: ",
            style: regularTextStyle.copyWith(
                color: AppTheme.darkBlue, fontWeight: FontWeight.bold)),
        new Text(car.anno ?? '-',
            style: regularTextStyle.copyWith(fontWeight: FontWeight.normal))
      ],
    );

    final _emissioni = new Row(
      children: <Widget>[
        new Text(
          "Emissioni: ",
          style: regularTextStyle.copyWith(
              color: AppTheme.darkBlue, fontWeight: FontWeight.bold),
        ),
        new Text(car.emissioni ?? '-',
            style: regularTextStyle.copyWith(fontWeight: FontWeight.normal))
      ],
    );

    final _percorrenza = new Row(
      children: <Widget>[
        new Text(
          "Percorrenza: ",
          style: regularTextStyle.copyWith(
              color: AppTheme.darkBlue, fontWeight: FontWeight.bold),
        ),
        new Text(car.km,
            style: regularTextStyle.copyWith(fontWeight: FontWeight.normal))
      ],
    );

    final carDetails = new Container(
      margin: EdgeInsets.only(left: 8.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _riferimento,
          _anno,
          _emissioni,
          _percorrenza,
        ],
      ),
    );

    final carCardContent = new Padding(
      padding: EdgeInsets.all(10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Text(car.title,
              style: headerTextStyle, textAlign: TextAlign.center),
          new SizedBox(height: 5.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Text(
                car.price,
                style: headerTextStyle,
              ),
              new Text(" - ", style: regularTextStyle),
              new Text("Iva Esclusa",
                  style: regularTextStyle.copyWith(
                      decoration: TextDecoration.underline))
            ],
          ),
          new SizedBox(height: 5.0),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              carDetails,
            ],
          ),
        ],
      ),
    );

    final carCard = Container(
      constraints: BoxConstraints(
          maxHeight: 170.0,
          minHeight: 155.0,
          maxWidth: MediaQuery.of(context).size.width,
          minWidth: MediaQuery.of(context).size.width),
      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      decoration: new BoxDecoration(
          color: AppTheme.lighterBlue,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          border: Border.all(color: AppTheme.lightBlue, width: 2.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                offset: new Offset(0.0, 6.0))
          ]),
      child: carCardContent,
    );

    final slider = AspectRatio(
      aspectRatio: 16 / 10,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            car.postImages[index],
            fit: BoxFit.fitWidth,
          );
        },
        autoplay: true,
        itemCount: car.postImages.length,

        //  control: new SwiperControl(color: AppTheme.orange),
      ),
    );

    final carDescrContent = new Container(
        margin: EdgeInsets.only(top: 110.0),
        child: new ListView.builder(
            controller: _controller,
            itemCount: (listDetails != null) ? listDetails.length : 0,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              Map<dynamic, dynamic> map = listDetails.elementAt(index);

              return new Container(
                  margin: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        map.values.elementAt(0),
                        style: headerTextStyle.copyWith(color: AppTheme.blue),
                      ),
                      new Text(
                        map.values.elementAt(1),
                        style:
                            regularTextStyle.copyWith(color: AppTheme.darkText),
                      ),
                    ],
                  ));
            }));

    final carDescr = new Container(
      margin: new EdgeInsets.fromLTRB(16.0, 78.0, 16.0, 24.0),
      child: carDescrContent,
      decoration: new BoxDecoration(
          color: AppTheme.nearlyWhite,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                offset: new Offset(0.0, 6.0))
          ]),
    );

    _launchTEL() async {
      const tel = 'tel:+390158123128';
      if (await canLaunch(tel)) {
        await launch(tel);
      } else {
        throw 'Impossibile chiamare il numero $tel';
      }
    }

    _launchMAIL() async {
      var mail =
          'mailto:info@pastoreautoveicoli.it?subject=Richiesta informazioni rif.${car.rif}&body=${car.title}\n\n${car.link}';
      if (await canLaunch(mail)) {
        await launch(mail);
      } else {
        throw 'Impossibile chiamare il numero $mail';
      }
    }

    final _favoriteButton = StreamBuilder<bool>(
        stream: myDatabase.isFavorite(int.parse(car.key)),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return FloatingActionButton(
                onPressed: () => myDatabase.removeFavorite(int.parse(car.key)),
                child: Icon(Icons.favorite, color: AppTheme.darkBlue));
          }
          return FloatingActionButton(
              onPressed: () => myDatabase.addFavorite(car),
              child: Icon(Icons.favorite_border, color: AppTheme.darkBlue));
        });

    return Scaffold(
        appBar: new AppBar(
          elevation: 1.0,
          iconTheme: new IconThemeData(color: AppTheme.darkBlue),
          backgroundColor: AppTheme.notWhite,
          actions: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.call),
                onPressed: _launchTEL,
              ),
              decoration:
                  BoxDecoration(color: AppTheme.orange, shape: BoxShape.circle),
            ),
            SizedBox(width: 5.0),
            Container(
              decoration:
                  BoxDecoration(color: AppTheme.orange, shape: BoxShape.circle),
              child: IconButton(
                icon: Icon(Icons.mail_outline),
                onPressed: _launchMAIL,
              ),
            ),
            SizedBox(width: 5.0),
            Container(
              decoration:
                  BoxDecoration(color: AppTheme.orange, shape: BoxShape.circle),
              child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share("${car.title}\n${car.link}",
                        subject:
                            "Ho trovato questo veicolo su Pastore Autoveicoli");
                  }),
            ),
            SizedBox(width: 5.0),
          ],
        ),
        body: new SingleChildScrollView(
            controller: _controller,
            child: SafeArea(
              child: new Column(
                children: <Widget>[
                  slider,
                  SizedBox(height: 20.0),
                  new Stack(
                    children: <Widget>[
                      carDescr,
                      carCard,
                    ],
                  )
                ],
              ),
            )),
        floatingActionButton:
            _favoriteButton /*new FloatingActionButton(
        onPressed: _toggleFavorite,
        backgroundColor: AppTheme.orange,
        mini: false,
        child: car.isFavorite
            ? Icon(Icons.favorite, color: AppTheme.darkBlue)
            : Icon(Icons.favorite_border, color: AppTheme.darkBlue),
      ),*/
        );
  }
}
