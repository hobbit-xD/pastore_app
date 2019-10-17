import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pastore_app/style.dart';
import 'package:pastore_app/favorites_database.dart';
import 'CarPage.dart';
import 'car.dart';

class HomePageUi extends StatefulWidget {
  final Car car;
  final MyDatabase myDatabase;

  HomePageUi(this.car, this.myDatabase);

  @override
  HomePageUiState createState() => new HomePageUiState(car, myDatabase);
}

class HomePageUiState extends State<HomePageUi> {
  final Car car;
  final MyDatabase myDatabase;
  HomePageUiState(this.car, this.myDatabase);

  @override
  Widget build(BuildContext context) {
    final headerTextStyle = TextStyle(
        color: AppTheme.darkBlue, fontSize: 15.0, fontWeight: FontWeight.w600);

    final regularTextStyle = TextStyle(
        color: AppTheme.nearlyBlack,
        fontSize: 14.0,
        fontWeight: FontWeight.w400);

    final subHeaderTextStyle = regularTextStyle.copyWith(
      fontSize: 13.0,
    );

    final carThumb = new Container(
      width: 120.0,
      height: 77.33,
      decoration: BoxDecoration(
          border: Border.all(color: AppTheme.nearlyBlack, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
          image: new DecorationImage(
              image: NetworkImage(car.image), fit: BoxFit.fill),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: AppTheme.deactivedText,
                blurRadius: 8.0,
                offset: new Offset(1.0, 6.0))
          ]),
    );

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

    final carDetails = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _riferimento,
        _anno,
        _emissioni,
        _percorrenza,
      ],
    );

    final _favoriteButton = StreamBuilder<bool>(
        stream: myDatabase.isFavorite(int.parse(car.key)),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return IconButton(
                onPressed: () => myDatabase.removeFavorite(int.parse(car.key)),
                icon: Icon(Icons.favorite, color: AppTheme.orangeText));
          }

          return IconButton(
              onPressed: () => myDatabase.addFavorite(car),
              icon: Icon(Icons.favorite_border, color: AppTheme.darkBlue));
        });

    final carCardContent = new Padding(
      padding: EdgeInsets.all(10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              carThumb,
              SizedBox(width: 10.0),
              carDetails,
            ],
          ),
          SizedBox(height: 5.0),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Text("Aggiungimi ai prefereriti ", style: subHeaderTextStyle),
              _favoriteButton
            ],
          ),
        ],
      ),
    );

    final carCard = Container(
      child: carCardContent,
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

    return new InkWell(
      onTap: () => Navigator.of(context).push(new PageRouteBuilder(
          pageBuilder: (_, __, ___) => new CarPage(car, myDatabase))),
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          constraints: BoxConstraints(
              maxHeight: 210.0,
              minHeight: 195.0,
              maxWidth: MediaQuery.of(context).size.width,
              minWidth: MediaQuery.of(context).size.width),
          //width: MediaQuery.of(context).size.width,
          child: carCard),
    ); //);
  }
}
