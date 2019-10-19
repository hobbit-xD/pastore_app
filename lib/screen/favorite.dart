import 'package:flutter/material.dart';
import 'package:pastore_app/database/favorites_database.dart';
import 'package:pastore_app/style/style.dart';
import 'package:pastore_app/screen/carPage.dart';
import 'package:pastore_app/car.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Car> _cars;
  final MyDatabase myDatabase;
  FavoritesScreen(this._cars, this.myDatabase);

  @override
  State<StatefulWidget> createState() {
    return FavoritesScreenState(_cars, myDatabase);
  }
}

class FavoritesScreenState extends State<FavoritesScreen> {
  final List<Car> _cars;
  MyDatabase myDatabase;
  FavoritesScreenState(this._cars, this.myDatabase);

  @override
  Widget build(BuildContext context) {
    final headerTextStyle = TextStyle(
        color: AppTheme.darkBlue, fontSize: 27.0, fontWeight: FontWeight.w600);

    final regularTextStyle = TextStyle(
        color: AppTheme.nearlyBlack,
        fontSize: 16.0,
        fontWeight: FontWeight.w400);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Preferiti",
            style: headerTextStyle,
          ),
          actions: <Widget>[
            StreamBuilder(
                stream: myDatabase.allFavoritesWatch,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () => myDatabase.removeAllFavorite(),
                      child: Row(children: <Widget>[
                        Text("Rimuovi tutto", style: regularTextStyle),
                        SizedBox(width: 5.0),
                        Icon(Icons.close)
                      ]),
                    ),
                  );
                }),
          ],
          elevation: 0.0,
        ),
        body: StreamBuilder(
          stream: myDatabase.allFavoritesWatch,
          builder: (context, snapshot) {
            var favorites = snapshot.data ?? List();
            if (favorites.length > 0) {
              return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: favorites.length,
                  itemBuilder: (BuildContext context, int index) => ListTile(
                        onTap: () {
                          Car tmp = _cars.firstWhere((Car c) =>
                              c.key.contains(favorites[index].id.toString()));

                          return Navigator.of(context).push(
                              new PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      new CarPage(tmp, myDatabase)));
                        },
                        leading: Icon(Icons.star),
                        title: Text(
                          favorites[index].title,
                          style: regularTextStyle,
                        ),
                        trailing: new IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () =>
                                myDatabase.removeFavorite(favorites[index].id)),
                      ));
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Non hai ancora aggiunto nessun veicolo nei preferiti',
                    style: headerTextStyle.copyWith(
                        color: AppTheme.nearlyBlack, fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
        ));
  }
}
