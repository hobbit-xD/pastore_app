/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      onTap: () => Navigator.of(context).push(
          new PageRouteBuilder(pageBuilder: (_, __, ___) => new CarPage(car))),
      child: new HomePageBody(car),
    );
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

    double defaultScreenWidth = 800.0;
    double defaultScreenHeight = 1280.0;

    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    final headerTextStyle = TextStyle(
        color: AppTheme.darkBlue,
        fontSize: ScreenUtil.instance.setSp(17.0),
        fontWeight: FontWeight.w600);

    final regularTextStyle = TextStyle(
        color: AppTheme.nearlyBlack,
        fontSize: ScreenUtil.instance.setSp(16.0),
        fontWeight: FontWeight.w400);

    final subHeaderTextStyle = regularTextStyle.copyWith(
      fontSize: ScreenUtil.instance.setSp(15.0),
    );

    /*  final carCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(113.0, 20.0, 13.0, 16.0),
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
                        color: AppTheme.darkText, fontWeight: FontWeight.w600),
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
                  ),
                  new Text(
                    " IVA esclusa",
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
                new Text("Aggiungimi ai preferiti", style: subHeaderTextStyle),
                new IconButton(
                  icon: (car.isFavorite
                      ? Icon(
                          Icons.bookmark,
                          color: AppTheme.orangeText,
                        )
                      : Icon(Icons.bookmark_border, color: AppTheme.darkText)),
                  onPressed: _toggleFavorite,
                ),
              ],
            ),
          )
        ],
      ),
    );
*/
    /* final carThumb = new Container(
      margin: EdgeInsets.symmetric(vertical: 30.0),
      alignment: FractionalOffset.centerLeft,
      width: 150.0,
      height: 100.0,
      decoration: BoxDecoration(
          border: Border.all(color: AppTheme.lightBlue, width: 1.0),
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
*/
    final carThumb = new Container(
      width: ScreenUtil.instance.setWidth(130.0),
      height: ScreenUtil.instance.setHeight(83.66),
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
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(8.0), vertical: ScreenUtil.instance.setHeight(0)),
      child: new Column(
        children: <Widget>[
          new SizedBox(
            height: ScreenUtil.instance.setHeight(12.0),
          ),
          new Text(car.title,
              style: headerTextStyle, textAlign: TextAlign.center),
          new SizedBox(
            height: ScreenUtil.instance.setHeight(5.0),
          ),
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
          new SizedBox(
            height: ScreenUtil.instance.setHeight(5.0),
          ),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              carThumb,
              carDetails,
            ],
          ),
          new Container(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Text("Aggiungimi ai prefereriti ", style: subHeaderTextStyle),
              GestureDetector(
                onTap: _toggleFavorite,
                child: (car.isFavorite
                    ? Icon(
                        Icons.favorite,
                        color: AppTheme.orangeText,
                      )
                    : Icon(Icons.favorite_border, color: AppTheme.darkText)),
              )
            ],
          )),
        ],
      ),
    );

    final carCard = Container(
      width: ScreenUtil.instance.setWidth(288.0),
      height: ScreenUtil.instance.setHeight(200.0),
      child: carCardContent,
      // margin: EdgeInsets.only(left: 46.0),
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
        margin: EdgeInsets.symmetric(vertical: ScreenUtil.instance.setHeight(8.0), horizontal: ScreenUtil.instance.setHeight(16.0)),
       /* child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth:  ScreenUtil.instance.setWidth(288.0),
              minHeight: ScreenUtil.instance.setHeight(200.0),
              maxHeight: ScreenUtil.instance.setHeight(200.0),
              maxWidth: ScreenUtil.screenWidth
            ),*/
            child: carCard);//);
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
*/