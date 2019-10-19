import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart';
import 'package:pastore_app/car.dart';

// assuming that your file is called filename.dart. This will give an error at first,
// but it's needed for moor to know about the generated code
part 'favorites_database.g.dart';

// this will generate a table called "Favorites" for us. The rows of that table will
// be represented by a class called "Favorites".
class Favorites extends Table {
  IntColumn get id => integer().customConstraint('UNIQUE')();
  TextColumn get rif => text()();
  TextColumn get title => text()();
}

// this annotation tells moor to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@UseMoor(tables: [Favorites])
class MyDatabase extends _$MyDatabase {
  MyDatabase()
      // Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db1.sqlite',
          // Good for debugging - prints SQL in the console
          logStatements: false,
        )));

  // Bump this when changing tables and columns.
  // Migrations will be covered in the next part.
  @override
  int get schemaVersion => 1;

  Future<List<Favorite>> get allFavoritesEntries => select(favorites).get();

  Stream<List<Favorite>> get allFavoritesWatch => select(favorites).watch();

  // watches all Favorites entries in a given category. The stream will automatically
  // emit new items whenever the underlying data changes.
/*
  Stream<bool> isFavorite(int rifId) {
    return (select(favorites)..where((favorite) => favorite.id.equals(rifId)))
        .watch()
        .map((favoritesList) => favoritesList.length >= 1);
  }
*/
  void addFavorite(Car car) {
    var favorite =
        Favorite(id: int.parse(car.key), rif: car.rif, title: car.title);

    into(favorites).insert(favorite);
  }

  void removeFavorite(int keyId) =>
      (delete(favorites)..where((t) => t.id.equals(keyId))).go();

  void removeAllFavorite() => (delete(favorites)).go();
/*
  Stream<bool> isFavorite(int keyId) {
    return (select(favorites).watch().map((favoritesList) =>
        favoritesList.where((favorite) => favorite.id == keyId).length >= 1));
  }
*/
  Stream<bool> isFavorite(int keyId) {
    return select(favorites).watch().map((favoritesList) =>
        favoritesList.any((favorite) => favorite.id == keyId));
  }
}
