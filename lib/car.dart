import 'package:firebase_database/firebase_database.dart';

class Car {
  String _key;
  String _title;
  String _rif;
  String _codice;
  String _alimentazione;
  String _allestimento;
  String _anno;
  String _assi;
  String _cambio;
  String _emissioni;
  String _colore;
  String _condizioni;
  String _km;
  String _link;
  String _posti;
  String _ptt;
  String _passo;
  String _portata;
  String _price;
  String _rimorchiabile;
  String _sospensioniAnt;
  String _sospensioniPost;
  String _trazione;
  String _descrizione;
  String _data;
  String _cEmissioni;
  String _image;
  List _postImages;
  List<dynamic> details;

  bool _isFavorite = false;

  Car(
    this._key,
    this._title,
    this._rif,
    this._codice,
    this._alimentazione,
    this._allestimento,
    this._anno,
    this._assi,
    this._cambio,
    this._emissioni,
    this._colore,
    this._condizioni,
    this._km,
    this._link,
    this._posti,
    this._ptt,
    this._passo,
    this._portata,
    this._price,
    this._rimorchiabile,
    this._sospensioniAnt,
    this._sospensioniPost,
    this._trazione,
    this._descrizione,
    this._data,
    this._cEmissioni,
    this._image,
    this._postImages,
    this.details,
  );

  Car.fromSnapshot(DataSnapshot snapshot) {
    this._alimentazione = snapshot.value['Alimentazione'];
    this._allestimento = snapshot.value['Allestimento'];
    this._anno = snapshot.value['Anno'];
    this._assi = snapshot.value['Assi'];
    this._cambio = snapshot.value['Cambio'];
    this._emissioni = snapshot.value['Classe emisioni'];
    this._codice = snapshot.value['Codice'];
    this._colore = snapshot.value['Colore'];
    this._condizioni = snapshot.value['Condizioni'];
    this._anno = snapshot.value['Data'];
    this._descrizione = snapshot.value['Descrizione'];
    this._emissioni = snapshot.value['Euro'];
    this._image = snapshot.value['Image'];
    this._km = snapshot.value['Km'];
    this._link = snapshot.value['Link'];
    this._posti = snapshot.value['Numero Posti'];
    this._ptt = snapshot.value['PTT - Peso Totale a Terra (Kg)'];
    this._passo = snapshot.value['Passo'];
    this._portata = snapshot.value['Portata'];
    this._price = snapshot.value['Price'];
    this._rif = snapshot.value['Rif'];
    this._key = snapshot.key;
    this._rimorchiabile = snapshot.value['Rimorchiabile'];
    this._sospensioniAnt = snapshot.value['Sospensioni anteriori'];
    this._sospensioniPost = snapshot.value['Sospensioni posteriori'];
    this._title = snapshot.value['Title'];
    this._trazione = snapshot.value['Trazione'];
    this._postImages = snapshot.value['postImages'];
    this.details = snapshot.value['CarPage'];
  }

  String get key => _key;

  String get title {
    return _title != '' ? _title : '';
  }

  set title(String value) {
    _title = value;
  }

  String get rif {
    return _rif != null ? _rif : '';
  }

  set rif(String value) {
    _rif = value;
  }

  String get anno {
    if (_anno != null) return _anno;
    return '';
  }

  set anno(String value) {
    _anno = value;
  }

  String get emissioni => _emissioni;

  set emissioni(String value) {
    _emissioni = value;
  }

  String get km => _km;

  set km(String value) {
    _km = value;
  }

  String get link => _link;

  set link(String value) {
    _link = value;
  }

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get descrizione => _descrizione;

  set descrizione(String value) {
    _descrizione = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  List<dynamic> get postImages => _postImages;

  set postImages(List<dynamic> value) {
    _postImages = value;
  }

  String get data => _data;

  set data(String value) {
    _data = value;
  }

  List<dynamic> get detailsMap => details;

  startsWith(String query) {
    return this.title.toUpperCase().contains(query.toUpperCase());
  }
}
