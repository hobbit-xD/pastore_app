import 'package:flutter/material.dart';
import 'package:pastore_app/car.dart';

class searchPage extends SearchDelegate<Car> {
  searchPage(this.cars);

  final List<Car> cars;

  final List<Car> recentCar = new List<Car>();

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  String get searchFieldLabel => "Cerca...";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      new IconButton(
          tooltip: "Clear",
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return new IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final list = query.isEmpty
        ? []
        : cars.where((Car c) => c.startsWith(query)).toList();
    print(list.length);

    if (list.length == 0)
      return new Center(
          child: Text(
        "Nessun veicolo trovato",
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ));
    else
      return new ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
              onTap: () {
                query = list[index].title;
                //showResults(context);
                close(context, list[index]);
              },
              leading: Icon(Icons.airport_shuttle),
              title: Text(list[index].title,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal))));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final list = query.isEmpty
        ? []
        : cars.where((Car c) => c.startsWith(query)).toList();

    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
            onTap: () {
              query = list[index].title;
              // showResults(context);
              close(context, list[index]);
            },
            leading: Icon(Icons.search),
            title: Text(list[index].title,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal))));
  }
}
