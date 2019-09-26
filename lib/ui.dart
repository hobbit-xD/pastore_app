import 'package:flutter/material.dart';
import 'package:pastore_app/style.dart';
import 'CarPage.dart';
import 'car.dart';

class HomeUI extends StatelessWidget {
  Car car;

  HomeUI(Car car) {
    this.car = car;
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
        onTap: () => Navigator.of(context).push(new PageRouteBuilder(
            pageBuilder: (_, __, ___) => new CarPage(car))),
        child: new Column(
          children: <Widget>[
            new HomePageBody(car),
          ],
        ));
  }
}

class HomePageBody extends StatelessWidget {
  final Car car;

  HomePageBody(this.car);

  @override
  Widget build(BuildContext context) {
    return new CarRow(car);
  }
}

class CarRow extends StatefulWidget {
  final Car car;
  CarRow(this.car);

  @override
  CarState createState() => new CarState(car);
}

class CarState extends State<CarRow> {
  final Car car;

  CarState(this.car);

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = const TextStyle(fontFamily: 'Poppins', height: 1.2);

    final headerTextStyle = baseTextStyle.copyWith(
        color: AppTheme.darkBlue, fontSize: 17.0, fontWeight: FontWeight.w600);

    final regularTextStyle = baseTextStyle.copyWith(
        color: AppTheme.lightText, fontSize: 9.0, fontWeight: FontWeight.w400);

    final subHeaderTextStyle = regularTextStyle.copyWith(
      fontSize: 14.0,
    );

    final carCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(115.0, 20.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            height: 4.0,
          ),
          new Text(
            car.title,
            style: headerTextStyle,
          ),
          new Container(
            height: 5.0,
          ),
          new Row(children: <Widget>[
            new Text(
              "Rif: ",
              style: subHeaderTextStyle.copyWith(
                  color: AppTheme.darkText, fontWeight: FontWeight.w600),
            ),
            new Text(
              car.rif,
              style: subHeaderTextStyle,
            ),
          ]),
          new Container(
            height: 4.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                  child: new Row(
                children: <Widget>[
                  new Text(
                    "Anno: ",
                    style: subHeaderTextStyle.copyWith(
                        color:  AppTheme.darkText, fontWeight: FontWeight.w600),
                  ),
                  new Text(
                    car.anno,
                    style: subHeaderTextStyle,
                  ),
                ],
              )),
              new Expanded(
                  child: new Row(
                children: <Widget>[
                  car.emissioni != null
                      ? new Text("Emissioni: " + car.emissioni,
                          style: subHeaderTextStyle)
                      : new SizedBox(),

                ],
              )),
            ],
          ),
          new Container(
            height: 4.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                  child: new Row(
                children: <Widget>[
                  new Text(
                    "Percorrenza: ",
                    style: subHeaderTextStyle.copyWith(
                        color: AppTheme.darkText, fontWeight: FontWeight.w600),
                  ),
                  new Text(
                    car.km,
                    style: subHeaderTextStyle,
                  ),
                ],
              )),
              new Expanded(
                  child: new Row(
                children: <Widget>[
                  new Text(
                    "Prezzo: ",
                    style: subHeaderTextStyle.copyWith(
                        color: AppTheme.darkText,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600),
                  ),
                  new Text(
                    car.price,
                    style: subHeaderTextStyle,
                  )
                ],
              )),
            ],
          ),
          new SizedBox(
            height: 5.0,
          ),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text("Aggiungimi ai preferiti",style: subHeaderTextStyle),
                new IconButton(
                  icon: (car.isFavorite
                      ? Icon(Icons.bookmark,color: AppTheme.orangeText,)
                      : Icon(Icons.bookmark_border,color: AppTheme.darkText)),
                  onPressed: _toggleFavorite,
                ),
              ],
            ),
          )
        ],
      ),
    );

/*
    final carThumb = new Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: new Image.network(
            car.image,
            width: 150.0,
            fit: BoxFit.contain,
          )),
    );
*/

    final carThumb = new Container(
/*      width: 150.0,
      height: 100.0,
      margin: EdgeInsets.symmetric(vertical: 25.0),
      alignment: FractionalOffset.centerLeft,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            offset: new Offset(0.0, 8.0),
          ),
        ],
      ),
      child: new Container(*/
      margin: EdgeInsets.symmetric(vertical: 30.0),
      alignment: FractionalOffset.centerLeft,
      width: 150.0,
      height: 100.0,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.lightBlue,width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
        image: new DecorationImage(
            image: NetworkImage(car.image), fit: BoxFit.fill),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: AppTheme.deactivedText,
                blurRadius: 8.0,
                offset: new Offset(1.0, 6.0))
          ]
      ),
      //    ),
    );

    final carCard = new Container(
      child: carCardContent,
      height: 185.0,
      margin: EdgeInsets.only(left: 46.0),
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

    return new Container(
      height: 185.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: new Stack(
        children: <Widget>[
          carCard,
          carThumb,
        ],
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (car.isFavorite) {
        car.setFavorite(false);
      } else {
        car.setFavorite(true);
      }
    });
  }
}
