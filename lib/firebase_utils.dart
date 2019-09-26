import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class FirebaseUtils{

  DatabaseReference _dbRef;
  StreamSubscription<Event> _messageSub;
  FirebaseDatabase _database = new FirebaseDatabase();
  DatabaseError error;

  static final FirebaseUtils _istance = new FirebaseUtils.internal();
  FirebaseUtils.internal();

  factory FirebaseUtils(){
    return _istance;
  }

  void initState(){
    _dbRef = _database.reference().child('Cars');
    _database.setPersistenceEnabled(true);
    //_database.setPersistenceCacheSizeBytes(1024*1000);
  }

  DatabaseError getError(){
    return error;
  }

  DatabaseReference getRef(){
    return _dbRef;
  }
  void dispose(){
    _messageSub.cancel();
  }
}