import 'package:flutter/material.dart';
import 'CarPage.dart';
import 'car.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Car> _cars;
  FavoritesScreen(this._cars);

  @override
  State<StatefulWidget> createState() {
    return FavoritesScreenState(_cars);
  }
}

class FavoritesScreenState extends State<FavoritesScreen> {
  final List<Car> _cars;
  FavoritesScreenState(this._cars);

  List<Car> get favoriteCars => _cars.where((c) => c.isFavorite).toList();

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = const TextStyle(fontFamily: 'Poppins', height: 1.2);

    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600);

    return Scaffold(
      body: new Center(
        child: favoriteCars.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Non hai ancora aggiunto nessun veicolo nei preferiti',
                  style: headerTextStyle,textAlign: TextAlign.center,
                ),
              )
            : ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: favoriteCars.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  onTap: () => Navigator.of(context).push(new PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          new CarPage(favoriteCars[index]))),
                  leading: Icon(Icons.star),
                  title: Text(
                    favoriteCars[index].title,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  trailing: new IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          if (favoriteCars[index].isFavorite) {
                            favoriteCars[index].setFavorite(false);
                          }
                        });
                      }),
                ),
              ),
      ),
    );
  }
}
