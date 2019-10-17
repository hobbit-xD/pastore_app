// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Favorite extends DataClass implements Insertable<Favorite> {
  final int id;
  final String rif;
  final String title;
  Favorite({@required this.id, @required this.rif, @required this.title});
  factory Favorite.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Favorite(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      rif: stringType.mapFromDatabaseResponse(data['${effectivePrefix}rif']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
    );
  }
  factory Favorite.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Favorite(
      id: serializer.fromJson<int>(json['id']),
      rif: serializer.fromJson<String>(json['rif']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'rif': serializer.toJson<String>(rif),
      'title': serializer.toJson<String>(title),
    };
  }

  @override
  FavoritesCompanion createCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      rif: rif == null && nullToAbsent ? const Value.absent() : Value(rif),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
    );
  }

  Favorite copyWith({int id, String rif, String title}) => Favorite(
        id: id ?? this.id,
        rif: rif ?? this.rif,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('id: $id, ')
          ..write('rif: $rif, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(rif.hashCode, title.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.id == this.id &&
          other.rif == this.rif &&
          other.title == this.title);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> id;
  final Value<String> rif;
  final Value<String> title;
  const FavoritesCompanion({
    this.id = const Value.absent(),
    this.rif = const Value.absent(),
    this.title = const Value.absent(),
  });
  FavoritesCompanion.insert({
    @required int id,
    @required String rif,
    @required String title,
  })  : id = Value(id),
        rif = Value(rif),
        title = Value(title);
  FavoritesCompanion copyWith(
      {Value<int> id, Value<String> rif, Value<String> title}) {
    return FavoritesCompanion(
      id: id ?? this.id,
      rif: rif ?? this.rif,
      title: title ?? this.title,
    );
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  final GeneratedDatabase _db;
  final String _alias;
  $FavoritesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _rifMeta = const VerificationMeta('rif');
  GeneratedTextColumn _rif;
  @override
  GeneratedTextColumn get rif => _rif ??= _constructRif();
  GeneratedTextColumn _constructRif() {
    return GeneratedTextColumn(
      'rif',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, rif, title];
  @override
  $FavoritesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'favorites';
  @override
  final String actualTableName = 'favorites';
  @override
  VerificationContext validateIntegrity(FavoritesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.rif.present) {
      context.handle(_rifMeta, rif.isAcceptableValue(d.rif.value, _rifMeta));
    } else if (rif.isRequired && isInserting) {
      context.missing(_rifMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Favorite map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Favorite.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(FavoritesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.rif.present) {
      map['rif'] = Variable<String, StringType>(d.rif.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    return map;
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $FavoritesTable _favorites;
  $FavoritesTable get favorites => _favorites ??= $FavoritesTable(this);
  @override
  List<TableInfo> get allTables => [favorites];
}
