import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pastore_app/style.dart';
import 'car.dart';

class CarPage extends StatefulWidget {
  final Car car;

  CarPage(this.car);

  @override
  State<StatefulWidget> createState() => CarPageState(car);
}

class CarPageState extends State<CarPage> {
  final Car car;
  ScrollController _controller;

  CarPageState(this.car);

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = const TextStyle(fontFamily: 'Poppins', height: 1.2);

    final headerTextStyle = baseTextStyle.copyWith(
        color: AppTheme.darkerBlue,
        fontSize: 16.0,
        fontWeight: FontWeight.w600);

    final subHeaderTextStyle = baseTextStyle.copyWith(
        color: AppTheme.nearlyBlack,
        fontSize: 14.0,
        fontWeight: FontWeight.w400);

    List<dynamic> listDetails = car.details;

    final carCardContent = new Container(
      margin: new EdgeInsets.symmetric(horizontal: 16.0),
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
            height: 4.0,
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
        ],
      ),
    );

    final carCard = new Container(
      margin: new EdgeInsets.fromLTRB(50.0, 12.0, 50.0, 0.0),
      child: carCardContent,
      height: 150.0,
      decoration: new BoxDecoration(
          border: Border.all(color: AppTheme.lightBlue, width: 2.0),
          color: AppTheme.lighterBlue,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
                offset: new Offset(0.0, 6.0))
          ]),
    );

    final slider = new ConstrainedBox(
      constraints: new BoxConstraints.expand(
          width: MediaQuery.of(context).size.width, height: 400.0),
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            car.postImages[index],
            fit: BoxFit.contain,
          );
        },
        autoplay: true,
        itemCount: car.postImages.length,
        pagination: new SwiperPagination(
          margin: new EdgeInsets.all(10.0),
        ),
        control: new SwiperControl(color: AppTheme.blue),
      ),
    );

    final carDescrContent = new Container(
        margin: EdgeInsets.only(top: 90.0),
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
                        style: subHeaderTextStyle.copyWith(
                            color: AppTheme.darkText),
                      ),
                    ],
                  ));
            }));

    final carDescr = new Container(
      margin: new EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 24.0),
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

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        iconTheme: new IconThemeData(color: AppTheme.orangeText),
      ),
      body: new SingleChildScrollView(
          controller: _controller,
          child: SafeArea(
            child: new Column(
              children: <Widget>[
                slider,
                new Stack(
                  children: <Widget>[
                    carDescr,
                    carCard,
                  ],
                )
              ],
            ),
          )),
      floatingActionButton: new FloatingActionButton(
        onPressed: _toggleFavorite,
        backgroundColor: AppTheme.orange,
        mini: false,
        child: car.isFavorite
            ? Icon(Icons.bookmark, color: AppTheme.blue)
            : Icon(Icons.bookmark_border, color: AppTheme.nearlyWhite),
      ),
    );
  }

  void _toggleFavorite() async {
    setState(() {
      if (car.isFavorite) {
        car.setFavorite(false);
      } else {
        car.setFavorite(true);
      }
    });
  }
}
